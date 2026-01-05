import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_pokedex/data/datasources/pokemon_remote_datasource.dart';
import 'package:pokemon_pokedex/domain/repositories/pokemon_repository.dart';
import 'package:pokemon_pokedex/domain/usecases/get_pokemons_usecase.dart';
import 'package:pokemon_pokedex/presentation/cubit/pokemon_cubit.dart';
import 'package:pokemon_pokedex/presentation/pages/pokemon_list_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PokemonCubit>(
          create: (_) {
            final dio = Dio();
            final datasource = PokemonRemoteDatasourceImpl(dio);
            final repository = PokemonRepositoryImpl(datasource);
            final usecase = GetPokemonsUsecase(repository);

            return PokemonCubit(usecase);
          },
        )
      ],
      child: MaterialApp(
        title: 'Pokédex', 
        home: const PokemonListPage(),
      )
    );
  }
}
