import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/domain/entities/pokemon.dart';
import 'package:pokemon_pokedex/presentation/cubit/pokemon_cubit.dart';
import 'package:pokemon_pokedex/presentation/widgets/evolution/pokemon_evolution.dart';
import 'package:pokemon_pokedex/presentation/widgets/header/pokemon_header.dart';
import 'package:pokemon_pokedex/presentation/widgets/skills/pokemon_skills_list.dart';
import 'package:pokemon_pokedex/presentation/widgets/stats/pokemon_%20statistic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_pokedex/presentation/widgets/types/pokemon_type_list.dart';

class PokemonDetailsPage extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonDetailsPage({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final relatedPokemons = context.read<PokemonCubit>().getNextEvolutions(pokemon);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  PokemonHeader(
                    title: Text(
                      pokemon.name,
                      style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 24),
                    ),
                    subtitle: Text('#${pokemon.number}', style: const TextStyle(fontSize: 12, color: Colors.white)),
                    superimposedImage: Positioned(
                      top: size.height * 0.05,
                      right: -5,
                      child: Image.network(pokemon.img, height: size.height * 0.35, fit: BoxFit.fitWidth),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.add_circle, size: 20, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: size.height * 0.12),
              Center(child: PokemonTypeList(types: pokemon.type)),

              Padding(
                padding: const EdgeInsets.only(left: 8, top: 16),
                child: Text('Habilidades', style: TextStyle(fontSize: 16)),
              ),
              Center(child: PokemonSkillsList(skills: pokemon.weaknesses)),

              Padding(
                padding: const EdgeInsets.only(left: 8, top: 16),
                child: Text('Estatísticas base', style: TextStyle(fontSize: 16)),
              ),
              PokemonStats(spawnChance: pokemon.spawnChance, avgSpawns: pokemon.avgSpawns),

              if (relatedPokemons.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 16),
                  child: Text('Relacionados', style: TextStyle(fontSize: 16)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: PokemonEvolution(pokemons: relatedPokemons),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
