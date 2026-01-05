import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_pokedex/domain/entities/pokemon.dart';
import 'package:pokemon_pokedex/domain/usecases/get_pokemons_usecase.dart';
import 'package:pokemon_pokedex/presentation/cubit/pokemon_sort.dart';
import 'package:pokemon_pokedex/presentation/cubit/pokemon_state.dart';

class PokemonCubit extends Cubit<PokemonState> {
  final GetPokemonsUsecase getPokemonsUsecase;

  PokemonCubit(this.getPokemonsUsecase) : super(PokemonInitial());

  List<Pokemon> _allPokemons = [];
  String _query = '';
  PokemonSort _sort = PokemonSort.alphabetical;

  Future<void> fetchPokemons() async {
    emit(PokemonLoading());

    try {
      _allPokemons = await getPokemonsUsecase.call();
      _emitFilter();
    } catch (e) {
      emit(const PokemonError('Failed to load pokemons'));
    }
  }

  void updateQuery(String value) {
    _query = value;
    _emitFilter();
  }

  void updateSort(PokemonSort value) {
    _sort = value;
    _emitFilter();
  }

  void _emitFilter() {
    List<Pokemon> filter = List.from(_allPokemons);

    if (_query.isNotEmpty) {
      filter = filter.where((pokemon) {
        final nameMatch = pokemon.name.toLowerCase().contains(_query.toLowerCase());
        final codeMatch = pokemon.id.toString().contains(_query);

        return nameMatch || codeMatch;
      }).toList();
    }

    switch (_sort) {
      case PokemonSort.alphabetical:
        filter.sort((a, b) => a.name.compareTo(b.name));
        break;

      case PokemonSort.codeAsc:
        filter.sort((a, b) => a.id.compareTo(b.id));
        break;

      case PokemonSort.codeDesc:
        filter.sort((a, b) => b.id.compareTo(a.id));
        break;
    }

    emit(PokemonLoaded(pokemons: filter, query: _query, sort: _sort));
  }

  List<Pokemon> getNextEvolutions(Pokemon pokemon) {
    if (pokemon.nextEvolution == null) return [];

    return _allPokemons.where((p) {
      return pokemon.nextEvolution!.any((e) => e.num == p.number);
    }).toList();
  }

}