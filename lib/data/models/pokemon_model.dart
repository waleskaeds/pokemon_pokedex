import 'package:pokemon_pokedex/domain/entities/evolution.dart';
import 'package:pokemon_pokedex/domain/entities/pokemon.dart';

class PokemonModel extends Pokemon {
  PokemonModel({
    required super.id,
    required super.number,
    required super.name,
    required super.img,
    required super.type,
    required super.height,
    required super.weight,
    required super.egg,
    required super.spawnChance,
    required super.avgSpawns,
    required super.spawnTime,
    required super.weaknesses,
    super.candy,
    super.candyCount,
    super.multipliers,
    super.nextEvolution,
    super.prevEvolution,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      id: json['id'] as int,
      number: json['num'] as String,
      name: json['name'] as String,
      // usa sprite HTTPS da PokeAPI em vez da imagem do JSON por se tratar de URL HTTP
      img: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${json['id']}.png',
      type: List<String>.from(json['type']),
      height: json['height'] as String,
      weight: json['weight'] as String,
      candy: json['candy'] as String?,
      candyCount: json['candy_count'] as int?,
      egg: json['egg'] as String,
      spawnChance: (json['spawn_chance'] as num).toDouble(),
      avgSpawns: (json['avg_spawns'] as num).toDouble(),
      spawnTime: json['spawn_time'] as String,
      multipliers: json['multipliers'] != null ? List<double>.from(json['multipliers']) : null,
      weaknesses: List<String>.from(json['weaknesses']),
      nextEvolution: json['next_evolution'] != null
          ? (json['next_evolution'] as List).map((e) => Evolution(num: e['num'], name: e['name'])).toList()
          : null,
      prevEvolution: json['prev_evolution'] != null
          ? (json['prev_evolution'] as List).map((e) => Evolution(num: e['num'], name: e['name'])).toList()
          : null,
    );
  }
}
