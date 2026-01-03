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

  @override
  Future<List<Pokemon>> getPokemons() async {
    final response = await dio.get(
      'https://raw.githubusercontent.com/Biuni/PokemonGo-Pokedex/master/pokedex.json'
    );
    if(response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.data);
      final List<dynamic> results = data['pokemon'];
      
      return results.map((json) => PokemonModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load pokemons. Server error: ${response.statusCode}');
    }
  }
}