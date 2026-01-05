import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:pokemon_pokedex/presentation/pages/pokemon_list_page.dart';
import 'package:pokemon_pokedex/presentation/cubit/pokemon_cubit.dart';
import 'package:pokemon_pokedex/presentation/cubit/pokemon_state.dart';
import 'package:pokemon_pokedex/presentation/cubit/pokemon_sort.dart';
import 'package:pokemon_pokedex/domain/entities/pokemon.dart';
import 'package:pokemon_pokedex/presentation/widgets/cards/pokemon_card.dart';

class MockPokemonCubit extends MockCubit<PokemonState> implements PokemonCubit {}

void main() {
  late MockPokemonCubit cubit;

  setUp(() {
    cubit = MockPokemonCubit();

    when(() => cubit.fetchPokemons()).thenAnswer((_) async {});
  });

  Widget makeTestableWidget() {
    return MaterialApp(
      home: MediaQuery(
        data: const MediaQueryData(size: Size(1080, 1920)),
        child: BlocProvider<PokemonCubit>.value(value: cubit, child: const PokemonListPage()),
      ),
    );
  }

  final pokemon = Pokemon(
    id: 1,
    number: '001',
    name: 'Bulbasaur',
    img: 'url',
    type: const ['Grass'],
    weaknesses: const ['Fire'],
    spawnChance: 0.69,
    avgSpawns: 69,
    height: '',
    weight: '',
    egg: '',
    spawnTime: '',
  );

  testWidgets('exibe loading quando o estado é PokemonLoading', (tester) async {
    when(() => cubit.state).thenReturn(PokemonLoading());

    whenListen(cubit, Stream<PokemonState>.fromIterable([PokemonLoading()]), initialState: PokemonLoading());

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(makeTestableWidget());
      await tester.pump();
    });
  });

  testWidgets('exibe grid de pokemons quando o estado é PokemonLoaded', (tester) async {
    final loadedState = PokemonLoaded(pokemons: [pokemon], query: '', sort: PokemonSort.alphabetical);

    whenListen(cubit, Stream<PokemonState>.fromIterable([loadedState]), initialState: loadedState);

    when(() => cubit.state).thenReturn(loadedState);

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(makeTestableWidget());
      await tester.pumpAndSettle();
    });

    expect(find.byType(PokemonCard, skipOffstage: false), findsOneWidget);
  });

  testWidgets('exibe mensagem de erro quando o estado é PokemonError', (tester) async {
    final errorState = PokemonError('Erro inesperado ao carregar os Pokémons.');

    whenListen(cubit, Stream<PokemonState>.fromIterable([errorState]), initialState: errorState);

    when(() => cubit.state).thenReturn(errorState);

    await tester.pumpWidget(makeTestableWidget());
    await tester.pumpAndSettle();

    expect(find.text('Erro inesperado ao carregar os Pokémons.', skipOffstage: false), findsOneWidget);
  });
}
