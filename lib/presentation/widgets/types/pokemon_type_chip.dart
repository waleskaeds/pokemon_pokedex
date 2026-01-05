import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/presentation/theme/pokemon_type_colors.dart';
import 'package:pokemon_pokedex/presentation/theme/pokemon_type_icons.dart';

class PokemonTypeChip extends StatelessWidget {
  final String type;
  const PokemonTypeChip({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final color = PokemonTypeColors.get(type);
    final icon = PokemonTypeIcons.get(type);

    return IntrinsicWidth(
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Container(
              height: 26,
              padding: const EdgeInsets.only(left: 22, right: 12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.85),
                borderRadius: const BorderRadius.horizontal(right: Radius.circular(15)),
              ),
              alignment: Alignment.center,
              child: Text(
                type.toLowerCase(),
                style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          ),

          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Icon(icon, size: 18, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
