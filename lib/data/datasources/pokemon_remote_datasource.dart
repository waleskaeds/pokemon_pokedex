import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pokemon_pokedex/data/models/pokemon_model.dart';
import 'package:pokemon_pokedex/domain/entities/pokemon.dart';

abstract class PokemonRemoteDatasource {
  Future<List<Pokemon>> getPokemons();
}

class PokemonRemoteDatasourceImpl implements PokemonRemoteDatasource {
  final Dio dio;
  PokemonRemoteDatasourceImpl(this.dio);
  static const String url = 'https://raw.githubusercontent.com/Biuni/PokemonGo-Pokedex/master/pokedex.json';

  @override
  Future<List<Pokemon>> getPokemons() async {
    int attempts = 0;

    while (attempts < 3) {
      try {
        final response = await dio.get(url);

        if (response.statusCode == 200) {
          final Map<String, dynamic> data = jsonDecode(response.data);
          final List<dynamic> results = data['pokemon'];

          return results
              .map((json) => PokemonModel.fromJson(json))
              .toList();
        } else {
          throw Exception('server_error_${response.statusCode}');
        }
      } on DioException catch (e) {
        attempts++;

        if (attempts >= 3) {
          if (e.type == DioExceptionType.connectionError ||
              e.type == DioExceptionType.connectionTimeout) {
            throw Exception('no_internet');
          }

          throw Exception('server_error');
        }
      }
    }

    throw Exception('unexpected_error');
  }
}
