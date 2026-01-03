import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_pokedex/presentation/cubit/pokemon_cubit.dart';
import 'package:pokemon_pokedex/presentation/cubit/pokemon_sort.dart';
import 'package:pokemon_pokedex/presentation/cubit/pokemon_state.dart';

class PokemonFilters extends StatelessWidget {
  const PokemonFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonCubit, PokemonState>(
      builder: (context, state) {
        final currentSort = state is PokemonLoaded ? state.sort : PokemonSort.alphabetical;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: TextField(
                  onChanged: context.read<PokemonCubit>().updateQuery,
                  decoration: InputDecoration(
                    hintText: 'Nome ou código do Pokémon',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)),
                      child: Center(child: Icon(CupertinoIcons.slider_horizontal_3, color: Colors.white)),
                    ),
                    SizedBox(width: 16),
                    _SortChip(
                      label: 'alfabética (A-Z)',
                      selected: currentSort == PokemonSort.alphabetical,
                      onTap: () => context.read<PokemonCubit>().updateSort(PokemonSort.alphabetical),
                    ),
                    _SortChip(
                      label: 'código crescente',
                      selected: currentSort == PokemonSort.codeAsc,
                      onTap: () => context.read<PokemonCubit>().updateSort(PokemonSort.codeAsc),
                    ),
                    _SortChip(
                      label: 'código decrescente',
                      selected: currentSort == PokemonSort.codeDesc,
                      onTap: () => context.read<PokemonCubit>().updateSort(PokemonSort.codeDesc),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SortChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _SortChip({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label, style: TextStyle(color: selected ? Colors.white : Colors.black)),
        selected: selected,
        onSelected: (_) => onTap(),
        selectedColor: Colors.black,
        backgroundColor: Colors.white,
      ),
    );
  }
}
