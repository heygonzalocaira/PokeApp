import 'package:bloc_pokeapi/home/cubit/home_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_repository/poke_repository.dart';

class MockPokeRepository extends Mock implements PokeRepository {}

class MockPokemonModel extends Mock implements PokemonModel {}

void main() {
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
  group("HomeCubit - fetchPokemons()", () {
    late PokeRepository mockPokeRepository;
    late PokemonModel mockPokemonModel;
    setUp(() {
      mockPokeRepository = MockPokeRepository();
      mockPokemonModel = MockPokemonModel();
      when(() => mockPokeRepository.pokemonFavorities)
          .thenAnswer((_) => Stream.value(mockPokemons));
      when(() => mockPokeRepository.fetchRangePokemons())
          .thenAnswer((_) async => []);
      //when(() => HomeCubit(mockPokeRepository).state).thenReturn(
      //  const HomeState(
      //    status: HomeStatus.sucess,
      //    pokemons: [],
      //  ),
      //);
    });

    blocTest<HomeCubit, HomeState>(
      "Invokes fetchRangePokemons on PokeRepository emit success",
      build: () => HomeCubit(mockPokeRepository),
      seed: () => HomeState(
        status: HomeStatus.sucess,
        pokemons: List.generate(20, (index) => mockPokemonModel),
      ),
      act: (homeCubit) => homeCubit.fetchPokemons(),
      expect: () => <HomeState>[
        HomeState(
          status: HomeStatus.loading,
          pokemons: List.generate(20, (index) => mockPokemonModel),
        ),
        HomeState(
          status: HomeStatus.sucess,
          pokemons: List.generate(20, (index) => mockPokemonModel),
        ),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      "Invokes fetchRangePokemons on PokeRepository emit failure",
      build: () => HomeCubit(mockPokeRepository),
      seed: () => const HomeState(
        status: HomeStatus.failure,
      ),
      act: (homeCubit) => homeCubit.fetchPokemons(),
      expect: () => <HomeState>[
        const HomeState(
          status: HomeStatus.failure,
          pokemons: [],
        ),
      ],
    );
  });
}
