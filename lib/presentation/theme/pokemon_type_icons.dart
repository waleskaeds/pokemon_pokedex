import 'package:flutter/material.dart';

class PokemonTypeIcons {
  static const Map<String, IconData> _icons = {
    'fire': Icons.local_fire_department,
    'water': Icons.water_drop,
    'electric': Icons.flash_on,
    'grass': Icons.eco,
    'ice': Icons.ac_unit,
    'fighting': Icons.sports_mma,
    'poison': Icons.bug_report,
    'ground': Icons.landscape,
    'flying': Icons.air,
    'psychic': Icons.visibility,
    'bug': Icons.bug_report,
    'rock': Icons.terrain,
    'ghost': Icons.nightlight_round,
    'dragon': Icons.whatshot,
    'dark': Icons.dark_mode,
    'steel': Icons.construction,
    'fairy': Icons.auto_awesome,
    'normal': Icons.circle,
  };

  static IconData get(String type) {
    return _icons[type.toLowerCase()] ?? Icons.circle;
  }
}
