import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/presentation/theme/pokemon_type_colors.dart';
import 'package:pokemon_pokedex/presentation/theme/pokemon_type_icons.dart';

class PokemonSkillsChip extends StatelessWidget {
  final String skills;
  const PokemonSkillsChip({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    final color = PokemonTypeColors.get(skills);
    final icon = PokemonTypeIcons.get(skills);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(color: color.withOpacity(0.85), shape: BoxShape.circle),
          child: Icon(icon, size: 18, color: Colors.white),
        ),
        const SizedBox(width: 4),
        Text(
          skills.toLowerCase(),
          style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
