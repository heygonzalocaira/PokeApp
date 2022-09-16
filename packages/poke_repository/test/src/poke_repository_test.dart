// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_api/poke_api.dart';
import 'package:poke_repository/poke_repository.dart';

class MockPokeApiClient extends Mock implements PokeApiClient {}

void main() {
  late PokeApiClient mockPokeApiClient;
  late PokeRepository pokeRepository;

  final pokemons = [
    Pokemon(name: 'Pikachu', url: 'url'),
    Pokemon(name: 'Chamander', url: 'url'),
    Pokemon(name: 'Pikachu', url: 'url'),
  ];
  final pokemonAbilities = [
    PokemonAbility(name: 'Patada', url: 'url'),
    PokemonAbility(name: 'Puño', url: 'url'),
  ];
  group('PokeRepository', () {
    setUpAll(() {
      mockPokeApiClient = MockPokeApiClient();
      pokeRepository = PokeRepository(pokeApiClient: mockPokeApiClient);
    });
    group('getRangePokemons', () {
      setUp(() {
        when(() => mockPokeApiClient.getRangePokemons(any()))
            .thenAnswer((_) async => pokemons);
      });
      test('Arrive 3 pokemons', () async {
        final results = await pokeRepository.fetchRangePokemons();
        expect(results, [
          PokemonModel(name: 'Pikachu', url: 'url'),
          PokemonModel(name: 'Chamander', url: 'url'),
          PokemonModel(name: 'Pikachu', url: 'url'),
        ]);
        expect(results.length, 3);
        expect(results, isList);
        expect(results, contains(PokemonModel(name: 'Chamander', url: 'url')));
      });
    });

    group('getPokemonsAbilities', () {
      setUp(() {
        when(() => mockPokeApiClient.getPokemonsAbilities(any()))
            .thenAnswer((_) async => pokemonAbilities);
      });
      test('Arrive 2 pokemonsanilites', () async {
        final results = await pokeRepository.fetchPokemonsAbilities(1);
        expect(results.length, 2);
        expect(results, isList);
        //expect(results, same(PokemonAbilityModel(name: 'Patada', url: 'url')));
      });
    });
    group('- Functions return empty', () {
      setUp(() {
        when(() => mockPokeApiClient.getRangePokemons(any()))
            .thenAnswer((_) async => []);

        when(() => mockPokeApiClient.getPokemonsAbilities(any()))
            .thenAnswer((_) async => []);
      });
      test('fetchRangePokemons works and bring empty data', () {
        // Future that completes successfully
        expect(pokeRepository.fetchRangePokemons(), completes);
        expect(pokeRepository.fetchRangePokemons(), isNotNull);
      });
      test('fetchPokemonsAbilities works and bring empty data', () {
        expect(pokeRepository.fetchPokemonsAbilities(1), completes);
        expect(pokeRepository.fetchPokemonsAbilities(1), isNotNull);
      });
    });
    group('- Exceptions', () {
      setUp(() {
        when(() => mockPokeApiClient.getRangePokemons(any())).thenThrow(
          JsonDecodeException(),
        );
      });

      test('getRangePokemons throw a PokemonJsonException', () {
        expect(() => pokeRepository.fetchRangePokemons(), throwsException);
        expect(
          () => pokeRepository.fetchRangePokemons(),
          throwsA(isA<PokemonJsonException>()),
        );
        //expect(subject.fetchRangePokemons(), hasLength(20));
      });
    });

    group('- Exceptions', () {
      setUp(() {
        when(() => mockPokeApiClient.getRangePokemons(any())).thenThrow(
          JsonDesearilizationException(),
        );

        when(() => mockPokeApiClient.getPokemonsAbilities(any())).thenThrow(
          HttpException(message: ''),
        );
      });
      test('fetchRangePokemons throw a PokemonJsonException', () {
        expect(
          pokeRepository.fetchRangePokemons(),
          throwsA(isA<PokemonJsonException>()),
        );
        //expect(subject.fetchRangePokemons(), hasLength(20));
      });
      test('fetchPokemonsAbilities  throw a PokemonHttpException', () {
        //expect(() => mockPokeRepository.fetchPokemonsAbilities(1),
        //    throwsException);
        expect(
          pokeRepository.fetchPokemonsAbilities(1),
          throwsA(isA<PokemonHttpException>()),
        );
      });
    });
    group('-Functions return data ', () {
      setUp(() {
        when(() => mockPokeApiClient.getRangePokemons(any()))
            .thenAnswer((_) async => []);
      });
      test('fetchRangePokemons throw a PokemonJsonException', () {
        expect(pokeRepository.fetchRangePokemons(), completes);
        // lenght ?
      });
    });
  });
}
