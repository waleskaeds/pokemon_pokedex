import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pokemon_pokedex/data/datasources/pokemon_remote_datasource.dart';
import 'package:pokemon_pokedex/domain/entities/pokemon.dart';

class MockDio extends Mock implements Dio {}

class FakeRequestOptions extends Fake implements RequestOptions {}

void main() {
  late PokemonRemoteDatasourceImpl datasource;
  late MockDio dio;

  setUpAll(() {
    registerFallbackValue(FakeRequestOptions());
  });

  setUp(() {
    dio = MockDio();
    datasource = PokemonRemoteDatasourceImpl(dio);
  });

  const pokedexResponse = {
    'pokemon': [
      {
        'id': 1,
        'num': '001',
        'name': 'Bulbasaur',
        'type': ['Grass', 'Poison'],
        'height': '0.7 m',
        'weight': '6.9 kg',
        'egg': '2 km',
        'spawn_chance': 0.69,
        'avg_spawns': 69,
        'spawn_time': '20:00',
        'weaknesses': ['Fire', 'Ice'],
      },
    ],
  };

  final pokedexJsonString = jsonEncode(pokedexResponse);

  group('PokemonRemoteDatasourceImpl', () {
    test('deve retornar lista de Pokemons quando a requisição for bem-sucedida', () async {
      when(() => dio.get(any())).thenAnswer(
        (_) async => Response(
          data: pokedexJsonString,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final result = await datasource.getPokemons();

      expect(result, isA<List<Pokemon>>());
      expect(result.length, 1);
      expect(result.first.name, 'Bulbasaur');
      verify(() => dio.get(any())).called(1);
    });

    test('deve tentar novamente após falha e retornar sucesso na segunda tentativa', () async {
      int callCount = 0;

      when(() => dio.get(any())).thenAnswer((_) async {
        callCount++;

        if (callCount == 1) {
          throw DioException(
            type: DioExceptionType.connectionTimeout,
            requestOptions: RequestOptions(path: ''),
          );
        }

        return Response(
          data: pokedexJsonString,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        );
      });

      final result = await datasource.getPokemons();

      expect(result.isNotEmpty, true);
      verify(() => dio.get(any())).called(2);
    });

    test('deve lançar exceção no_internet após 3 tentativas com erro de conexão', () async {
      when(() => dio.get(any())).thenThrow(
        DioException(
          type: DioExceptionType.connectionError,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      expect(() => datasource.getPokemons(), throwsA(predicate((e) => e is Exception && e.toString().contains('no_internet'))));

      verify(() => dio.get(any())).called(3);
    });

    test('deve lançar exceção server_error quando status code for diferente de 200', () async {
      when(() => dio.get(any())).thenAnswer(
        (_) async => Response(
          data: 'error',
          statusCode: 500,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      expect(() => datasource.getPokemons(), throwsA(predicate((e) => e is Exception && e.toString().contains('server_error'))));
    });
  });
}
