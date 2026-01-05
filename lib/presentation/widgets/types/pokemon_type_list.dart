import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/presentation/widgets/types/pokemon_type_chip.dart';

class PokemonTypeList extends StatelessWidget {
  final List<String> types;

  const PokemonTypeList({super.key, required this.types});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: types.map((type) {
        return PokemonTypeChip(type: type);
      }).toList(),
    );
  }
}
