import 'package:flutter/material.dart';
import '../../domain/entities/pokemon.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image.network(pokemon.img, fit: BoxFit.contain)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(pokemon.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('#${pokemon.number}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [Icon(Icons.add_circle, size: 20)]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
