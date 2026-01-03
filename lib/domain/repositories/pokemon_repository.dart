import 'package:pokemon_pokedex/data/datasources/pokemon_remote_datasource.dart';
import 'package:pokemon_pokedex/domain/entities/pokemon.dart';

abstract class PokemonRepository {
  Future<List<Pokemon>> getPokemons();
}

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDatasource remoteDatasource;
  PokemonRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<Pokemon>> getPokemons() async {
    try {
      return await remoteDatasource.getPokemons();
    } catch (e){
      throw Exception('Error fetching pokemons');
    }
  }
}