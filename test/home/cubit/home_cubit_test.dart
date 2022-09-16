import 'package:bloc_pokeapi/home/cubit/home_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_repository/poke_repository.dart';

class MockPokeRepository extends Mock implements PokeRepository {}

class MockPokemonModel extends Mock implements PokemonModel {}

void main() {
  final mockPokemons = [
    const PokemonModel(
      name: "",
      url: "",
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
  group("HomeCubit - fetchPokemons()", () {
    late PokeRepository mockPokeRepository;
    late PokemonModel mockPokemonModel;
    setUp(() {
      mockPokeRepository = MockPokeRepository();
      mockPokemonModel = MockPokemonModel();
      when(() => mockPokeRepository.pokemonFavorities)
          .thenAnswer((_) => const Stream.empty());

      //when(() => HomeCubit(mockPokeRepository).state).thenReturn(
      //  const HomeState(
      //    status: HomeStatus.sucess,
      //    pokemons: [],
      //  ),
      //);
    });

    blocTest<HomeCubit, HomeState>(
      "Invokes fetchRangePokemons on PokeRepository"
      "When fetch return a empty",
      setUp: () {
        when(() => mockPokeRepository.fetchRangePokemons())
            .thenAnswer((_) async => []);
      },
      build: () => HomeCubit(mockPokeRepository),
      seed: () => HomeState(
        status: HomeStatus.sucess,
        pokemons: List.generate(20, (index) => const PokemonModel(name: "", url: "")),
      ),
      act: (homeCubit) => homeCubit.fetchPokemons(),
      expect: () => <HomeState>[
        HomeState(
          status: HomeStatus.loading,
          pokemons:
              List.generate(20, (index) => const PokemonModel(name: "", url: "")),
        ),
        const HomeState(
          status: HomeStatus.sucess,
          pokemons: [],
        ),
      ],
    );
    blocTest<HomeCubit, HomeState>(
      "Invokes fetchRangePokemons on PokeRepository"
      "When fetchRangePokemons return a list with 20 items",
      setUp: () {
        when(() => mockPokeRepository.fetchRangePokemons()).thenAnswer(
            (_) async =>
                List.generate(20, (index) => const PokemonModel(name: "", url: "")));
      },
      build: () => HomeCubit(mockPokeRepository),
      act: (homeCubit) => homeCubit.fetchPokemons(),
      expect: () => <HomeState>[
        HomeState(
          status: HomeStatus.sucess,
          pokemons:
              List.generate(20, (index) => const PokemonModel(name: "", url: "")),
        ),
      ],
    );
    blocTest<HomeCubit, HomeState>(
      "Invokes fetchRangePokemons on PokeRepository"
      "When fetchRangePokemons return a list with 20 items (seed State loading)",
      setUp: () {
        when(() => mockPokeRepository.fetchRangePokemons()).thenAnswer(
            (_) async =>
                List.generate(20, (index) => const PokemonModel(name: "", url: "")));
      },
      build: () => HomeCubit(mockPokeRepository),
      seed: () => const HomeState(status: HomeStatus.loading),
      act: (homeCubit) => homeCubit.fetchPokemons(),
      expect: () => <HomeState>[
        HomeState(
          status: HomeStatus.sucess,
          pokemons:
              List.generate(20, (index) => const PokemonModel(name: "", url: "")),
        ),
      ],
    );
    blocTest<HomeCubit, HomeState>(
      "Invokes fetchRangePokemons on PokeRepository"
      "Forcing an exception",
      setUp: (() => when(() => mockPokeRepository.fetchRangePokemons())
          .thenThrow(Exception())),
      build: () => HomeCubit(mockPokeRepository),
      act: (homeCubit) => homeCubit.fetchPokemons(),
      expect: () => <HomeState>[
        const HomeState(
          status: HomeStatus.failure,
          errorMessage: "Exception",
        ),
      ],
    );
    blocTest<HomeCubit, HomeState>(
      "Invokes fetchRangePokemons on PokeRepository"
      "Forcing PokemonHttpException with loading state",
      setUp: (() => when(() => mockPokeRepository.fetchRangePokemons())
          .thenThrow(PokemonHttpException(null, stackTrace: StackTrace.empty))),
      build: () => HomeCubit(mockPokeRepository),
      seed: () => const HomeState(status: HomeStatus.loading),
      act: (homeCubit) => homeCubit.fetchPokemons(),
      expect: () => <HomeState>[
        const HomeState(
          status: HomeStatus.failureLoadMore,
          errorMessage: "Instance of 'PokemonHttpException'",
        ),
      ],
    );
    blocTest<HomeCubit, HomeState>(
      "Invokes fetchRangePokemons on PokeRepository"
      "Forcing PokemonJsonException",
      setUp: (() => when(() => mockPokeRepository.fetchRangePokemons())
          .thenThrow(PokemonJsonException(null, stackTrace: StackTrace.empty))),
      build: () => HomeCubit(mockPokeRepository),
      act: (homeCubit) => homeCubit.fetchPokemons(),
      expect: () => <HomeState>[
        const HomeState(
          status: HomeStatus.failure,
          errorMessage: "Instance of 'PokemonJsonException'",
        ),
      ],
    );
  });
}
