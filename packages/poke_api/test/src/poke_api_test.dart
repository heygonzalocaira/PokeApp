// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:poke_api/poke_api.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  late http.Client mockHttpClient;
  late PokeApiClient pokeApiClient;

  setUpAll(() {
    mockHttpClient = MockHttpClient();
    pokeApiClient = PokeApiClient(httpClient: mockHttpClient);
    registerFallbackValue(FakeUri());
  });

  group('Constructor', () {
    test('does not require an httpClient', () {
      expect(PokeApiClient(), isNotNull);
    });
  });
  group('getRangePokemons', () {
    test('return getRangePokemons on valid resposne', () async {
      final mockResponse = MockResponse();
      when(() => mockResponse.statusCode).thenReturn(200);
      when(() => mockResponse.body).thenReturn(
        '''
        {
          "abilities": [
            {
              "ability": {
                "name": "overgrow",
                "url": "https://pokeapi.co/api/v2/ability/65/"
              },
              "is_hidden": false,
              "slot": 1
            }
          ]
        }
        ''',
      );
      when(() => mockHttpClient.get(any()))
          .thenAnswer((_) async => mockResponse);

      final results = await pokeApiClient.getPokemonsAbilities(2);
      expect(
        results[0],
        isA<PokemonAbility>()
            .having((item) => item.name, 'name', 'overgrow')
            .having(
              (item) => item.url,
              'url',
              'https://pokeapi.co/api/v2/ability/65/',
            ),
      );
    });
    test('throws HttpRequestFailure on non 200 resposne', () async {
      final mockResponse = MockResponse();
      when(() => mockResponse.statusCode).thenReturn(400);
      when(() => mockHttpClient.get(any()))
          .thenAnswer((_) async => mockResponse);

      expect(
        () async => pokeApiClient.getRangePokemons(0),
        throwsA(isA<HttpRequestFailure>()),
      );
    });
    test('throws JsonDecodeException on Error Response', () async {
      final mockResponse = MockResponse();
      when(() => mockResponse.statusCode).thenReturn(200);
      when(() => mockResponse.body).thenReturn('{[]}');
      when(() => mockHttpClient.get(any()))
          .thenAnswer((_) async => mockResponse);

      expect(
        () async => pokeApiClient.getPokemonsAbilities(1),
        throwsA(isA<JsonDecodeException>()),
      );
    });
    test('throws JsonDesearilizationException on Error Response', () async {
      final mockResponse = MockResponse();
      when(() => mockResponse.statusCode).thenReturn(200);
      when(() => mockResponse.body).thenReturn('{"abilities":[{}]}');
      when(() => mockHttpClient.get(any()))
          .thenAnswer((_) async => mockResponse);

      expect(
        () async => pokeApiClient.getPokemonsAbilities(1),
        throwsA(isA<JsonDesearilizationException>()),
      );
    });
  });
  test('Http request works well', () async {
    const query = 'mock-query';
    final mockResponse = MockResponse();
    when(() => mockResponse.statusCode).thenReturn(200);
    when(() => mockResponse.body).thenReturn('{"results":{}}');
    when(() => mockHttpClient.get(any())).thenAnswer((_) async => mockResponse);
    try {
      await pokeApiClient.getRangePokemons(0);
    } catch (_) {}
    verify(
      () => mockHttpClient.get(
        Uri.https(
          'pokeapi.co',
          '/api/v2/pokemon',
          {'offset': query, 'limit': 20},
        ),
      ),
    ).called(1);
  });
  test('the http call completes with an error', () async {
    final mockResponse = MockResponse();
    //when(() => mockResponse.statusCode).thenThrow(200);
    when(() => mockHttpClient.get(any())).thenThrow(Exception);
    try {
      await pokeApiClient.getRangePokemons(0);
    } catch (e) {
      expect(e, HttpException);
    }
    // expect(
    //   await pokeApiClient.getRangePokemons(0),
    //   throwsA(isA<HttpException>()),
    // );
  });
}
