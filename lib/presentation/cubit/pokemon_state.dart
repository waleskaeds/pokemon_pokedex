import 'package:equatable/equatable.dart';
import 'package:pokemon_pokedex/domain/entities/pokemon.dart';
import 'package:pokemon_pokedex/presentation/cubit/pokemon_sort.dart';

abstract class PokemonState extends Equatable {
  const PokemonState();
  
  @override
  List<Object?> get props => [];
}

class PokemonInitial extends PokemonState {}

class PokemonLoading extends PokemonState {}

class PokemonLoaded extends PokemonState {
  final List<Pokemon> pokemons;
  final String query;
  final PokemonSort sort;
  
  const PokemonLoaded({required this.pokemons, required this.query, required this.sort});

  @override
  List<Object?> get props => [pokemons, query, sort];
}

class PokemonError extends PokemonState {
  final String message;
  const PokemonError(this.message);

  @override
  List<Object?> get props => [message];
}
