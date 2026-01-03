import 'package:pokemon_pokedex/domain/entities/pokemon.dart';
import 'package:pokemon_pokedex/domain/repositories/pokemon_repository.dart';

class GetPokemonsUsecase {
  final PokemonRepository repository;
  GetPokemonsUsecase(this.repository);

  Future<List<Pokemon>> call() async {
    return await repository.getPokemons();
  }

}