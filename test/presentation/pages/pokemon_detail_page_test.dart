import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:pokemon_pokedex/presentation/cubit/pokemon_state.dart';

import 'package:pokemon_pokedex/presentation/pages/pokemon_details_page.dart';
import 'package:pokemon_pokedex/presentation/cubit/pokemon_cubit.dart';
import 'package:pokemon_pokedex/domain/entities/pokemon.dart';

class MockPokemonCubit extends Mock implements PokemonCubit {}

class PokemonFake extends Fake implements Pokemon {}

void main() {
  late MockPokemonCubit cubit;

  setUpAll(() {
    registerFallbackValue(PokemonFake());
  });

  setUp(() {
    cubit = MockPokemonCubit();

    when(() => cubit.stream).thenAnswer((_) => const Stream.empty());
    when(() => cubit.state).thenReturn(PokemonInitial());
    when(() => cubit.getNextEvolutions(any())).thenReturn([]);
  });

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

  Widget makeTestableWidget() {
    return MaterialApp(
      home: BlocProvider<PokemonCubit>.value(
        value: cubit,
        child: PokemonDetailsPage(pokemon: pokemon),
      ),
    );
  }

  testWidgets('exibe informações básicas do Pokémon', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1080, 1920));

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(makeTestableWidget());
      await tester.pumpAndSettle();
    });

    expect(find.text('Bulbasaur'), findsOneWidget);
    expect(find.text('#001'), findsOneWidget);
    expect(find.text('Habilidades'), findsOneWidget);
    expect(find.text('Estatísticas base'), findsOneWidget);
  });

  testWidgets('fecha o dialog ao tocar no botão de fechar', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1080, 1920));

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(makeTestableWidget());
      await tester.pumpAndSettle();
    });

    expect(find.byType(Dialog), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add_circle));
    await tester.pumpAndSettle();

    expect(find.byType(Dialog), findsNothing);
  });
}
