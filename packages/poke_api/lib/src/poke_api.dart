// ignore_for_file: public_member_api_docs

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:poke_api/src/models/pokemon.dart';
import 'package:poke_api/src/models/pokemon_ability.dart';

/// {@template poke_api}
/// My new Flutter package
/// {@endtemplate}
class PokeApiClient {
  PokeApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  final String _baseUrlPokemon = 'pokeapi.co';

  Future<List<Pokemon>> getRangePokemons(int offset) async {
    final query = <String, String>{'offset': offset.toString(), 'limit': '20'};
    final uri = Uri.http(_baseUrlPokemon, '/api/v2/pokemon', query);
    return _fetchPokemonData(uri);
  }

  Future<List<Pokemon>> _fetchPokemonData(Uri uri) async {
    http.Response response;
    List body;
    try {
      response = await _httpClient.get(uri);
    } on Exception {
      throw HttpException();
    }
    if (response.statusCode != 200) {
      throw HttpRequestFailure(response.statusCode);
    }
    try {
      body = jsonDecode(response.body)['results'] as List;
    } on Exception {
      throw JsonDecodeException();
    }
    try {
      return body
          .map((item) => Pokemon.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (_) {
      throw JsonDesearilizationException();
    }
  }

  // Functions to get abilities from a pokemon
  Future<List<PokemonAbility>> getPokemonsAbilities(int index) async {
    final uri = Uri.http(_baseUrlPokemon, '/api/v2/pokemon/$index');
    return _fetchPokemonAbility(uri);
  }

  Future<List<PokemonAbility>> _fetchPokemonAbility(Uri uri) async {
    http.Response response;
    List body;
    try {
      response = await _httpClient.get(uri);
    } on Exception {
      throw HttpException();
    }
    if (response.statusCode != 200) {
      throw HttpRequestFailure(response.statusCode);
    }
    try {
      body = jsonDecode(response.body)['abilities'] as List;
    } on Exception {
      throw JsonDecodeException();
    }
    try {
      return body
          .map(
            (item) => PokemonAbility.fromJson(
                item['ability'] as Map<String, dynamic>),
          )
          .toList();
    } catch (_) {
      throw JsonDesearilizationException();
    }
  }
}

class JsonDesearilizationException implements Exception {}

class JsonDecodeException implements Exception {}

class HttpRequestFailure implements Exception {
  HttpRequestFailure(this.statusCode);
  final int statusCode;
}

class HttpException implements Exception {}
