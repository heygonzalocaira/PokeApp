// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:bloc_pokeapi/home/home.dart';
import 'package:bloc_pokeapi/home/view/favorite_tab.dart';
import 'package:bloc_pokeapi/home/view/home_page.dart';
import 'package:bloc_pokeapi/home/view/pokemon_list_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:poke_repository/poke_repository.dart';
import 'package:bloc_test/bloc_test.dart';

class MockPokeRepository extends Mock implements PokeRepository {}

class MockHomeCubit extends MockBloc<HomeCubit, HomeState>
    implements HomeCubit {}

void main() {
  late HomeCubit mockHomeCubit;
  late PokeRepository mockPokeRepository;
  final mockPokemons = [
    const PokemonModel(
      name: "pikachu",
      url: "https://google.com",
    ),
    const PokemonModel(
      name: "squirtle",
      url: "https://google.com",
    ),
    const PokemonModel(
      name: "chamander",
      url: "https://google.com",
    ),
  ];
  group("HomePage UI -", () {
    setUp(() {
      mockPokeRepository = MockPokeRepository();
      mockHomeCubit = MockHomeCubit();
      when((() => mockPokeRepository.pokemonFavorities))
          .thenAnswer((_) => const Stream.empty());
    });
    testWidgets("1- Pokemons' list is empty", (tester) async {
      when(() => mockHomeCubit.state).thenReturn(
        const HomeState(
          status: HomeStatus.sucess,
          pokemons: [],
        ),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: RepositoryProvider(
            create: (context) => mockPokeRepository,
            child: BlocProvider.value(
              value: mockHomeCubit,
              child: const DefaultTabController(
                length: 2,
                child: Scaffold(
                  body: TabBarView(
                    children: [
                      PokemonListTab(),
                      FavoriteTab(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      expect(find.byType(PokemonCard), findsNothing);
    });
    testWidgets("2- Pokemons' list with 3 items", (tester) async {
      when(() => mockHomeCubit.state).thenReturn(
        HomeState(status: HomeStatus.sucess, pokemons: mockPokemons),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: RepositoryProvider(
            create: (context) => mockPokeRepository,
            child: BlocProvider.value(
              value: mockHomeCubit,
              child: const HomeView(title: ''),
            ),
          ),
        ),
      );
      expect(find.byType(PokemonCard), findsNWidgets(mockPokemons.length));
    });
    testWidgets("3- Finding a widget error", (tester) async {
      when(() => mockHomeCubit.state).thenReturn(
        const HomeState(status: HomeStatus.failure),
      );
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: mockPokeRepository,
          child: MaterialApp(
            home: BlocProvider.value(
              value: mockHomeCubit,
              child: const PokemonListTab(),
            ),
          ),
        ),
      );
      expect(find.byType(PokemonViewFailure), findsOneWidget);
    });
    testWidgets("4- Loading data", (tester) async {
      when(() => mockHomeCubit.state).thenReturn(
        const HomeState(status: HomeStatus.initital),
      );
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: mockPokeRepository,
          child: MaterialApp(
            home: BlocProvider.value(
              value: mockHomeCubit,
              child: const PokemonListTab(),
            ),
          ),
        ),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
