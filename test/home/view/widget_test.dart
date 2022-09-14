// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:bloc_pokeapi/home/cubit/home_cubit.dart';
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
    PokemonModel(
      name: "pikachu",
      url: "https://google.com",
    ),
    PokemonModel(
      name: "squirtle",
      url: "https://google.com",
    ),
    PokemonModel(
      name: "chamander",
      url: "https://google.com",
    ),
  ];
  group("Verifying UI draw empty widget", () {
    setUp(() {
      mockPokeRepository = MockPokeRepository();
      mockHomeCubit = HomeCubit(mockPokeRepository);
      when((() => mockPokeRepository.pokemonFavorities))
          .thenAnswer((_) => const Stream.empty());
    });
    testWidgets("A list of pokemon is empty", (tester) async {
      //final homeState = HomeState();
      when(() => mockHomeCubit.state).thenReturn(HomeState());
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
      expect(find.byType(PokemonListTab), findsOneWidget);
    });
    testWidgets("Second list of pokemon is empty", (tester) async {
      final homeState = HomeState();
      when(() => mockHomeCubit.state)
          .thenReturn(homeState.copyWith(pokemons: []));
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
      expect(find.byType(HomeView), findsOneWidget);
    });
  });
  /*
  group("Pokemons list", () {
    late HomeCubit pokemonCubit;
    setUp(() {
      pokemonCubit = MockHomeCubit();
      when(() => pokemonCubit.state).thenReturn(
        HomeState(status: HomeStatus.sucess, pokemons: mockPokemons),
      );
    });
    testWidgets("There are 3 pokomens in the list", (tester) async {
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: pokeRepository,
          child: const MaterialApp(
            home: DefaultTabController(
              length: 2,
              child: Scaffold(
                body: TabBarView(
                  children: [
                    PokemonListTab(),
                    SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
      expect(find.byType(PokemonCard), findsNWidgets(mockPokemons.length));
    });
  });

  group("Pokemon error", () {
    late HomeCubit pokemonCubit;
    setUp(() {
      pokemonCubit = MockHomeCubit();
      when(() => pokemonCubit.state).thenReturn(
        const HomeState(status: HomeStatus.failure),
      );
    });
    testWidgets("HomeState status is failure", (tester) async {
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: pokeRepository,
          child: const MaterialApp(
            home: DefaultTabController(
              length: 2,
              child: Scaffold(
                body: TabBarView(
                  children: [
                    PokemonListTab(),
                    SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
     expect(find.byType(PokemonViewSuccess), findsNWidgets(mockPokemons.length));
    });

  });
*/
}
