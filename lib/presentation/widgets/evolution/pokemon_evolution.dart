import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/domain/entities/pokemon.dart';
import 'package:pokemon_pokedex/presentation/widgets/cards/pokemon_card.dart';

class PokemonEvolution extends StatelessWidget {
  final List<Pokemon> pokemons;

  const PokemonEvolution({super.key, required this.pokemons});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: pokemons.map((pokemon) {
        return SizedBox(width: 120, child: PokemonCard(pokemon: pokemon));
      }).toList(),
    );
  }
}
