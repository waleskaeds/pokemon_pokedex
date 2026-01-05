import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/presentation/widgets/stats/statbar.dart';

class PokemonStats extends StatelessWidget {
  final double spawnChance;
  final double avgSpawns;

  const PokemonStats({super.key, required this.spawnChance, required this.avgSpawns});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StatBar(label: 'Spawn chance:', value: spawnChance, maxValue: 1.0, color: const Color.fromRGBO(62, 179, 151, 1)),

          StatBar(label: 'Avg. spawns:', value: avgSpawns, maxValue: 100, color: const Color.fromRGBO(62, 179, 151, 1)),

          StatBar(label: 'Total:', value: avgSpawns + spawnChance, maxValue: 100, color: const Color.fromRGBO(23, 93, 77, 1)),
        ],
      ),
    );
  }
}
