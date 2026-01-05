import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_pokedex/presentation/widgets/filters/pokemon_filters.dart';
import 'package:pokemon_pokedex/presentation/widgets/header/pokemon_list_header.dart';
import '../cubit/pokemon_cubit.dart';
import '../cubit/pokemon_state.dart';
import '../widgets/cards/pokemon_card.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key});

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  @override
  void initState() {
    super.initState();
    context.read<PokemonCubit>().fetchPokemons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: PokemonListHeader()),

          const SliverToBoxAdapter(
            child: PokemonFilters(),
          ),

          BlocBuilder<PokemonCubit, PokemonState>(
            builder: (context, state) {
              if (state is PokemonLoading) {
                return const SliverFillRemaining(hasScrollBody: false, child: Center(child: CircularProgressIndicator()));
              }

              if (state is PokemonLoaded) {
                return SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return PokemonCard(pokemon: state.pokemons[index]);
                    }, childCount: state.pokemons.length),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.75,
                    ),
                  ),
                );
              }

              if (state is PokemonError) {
                return SliverFillRemaining(hasScrollBody: false, child: Center(child: Text(state.message)));
              }

              return const SliverToBoxAdapter(child: SizedBox.shrink());
            },
          ),
        ],
      ),
    );
  }
}
