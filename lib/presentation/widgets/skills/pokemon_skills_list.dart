import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/presentation/widgets/skills/pokemon_skills_chip.dart';

class PokemonSkillsList extends StatelessWidget {
  final List<String> skills;

  const PokemonSkillsList({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Wrap(
        spacing: 24,
        runSpacing: 12,
        children: skills.map((weakness) {
          return PokemonSkillsChip(skills: weakness);
        }).toList(),
      ),
    );
  }
}
