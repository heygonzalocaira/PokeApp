// ignore_for_file: public_member_api_docs

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:poke_api/src/models/pokemon.dart';

/// {@template poke_api}
/// My new Flutter package
/// {@endtemplate}
class PokeApiClient {
  PokeApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  /// {@macro poke_api}
  String endPoint = 'pokeapi.co';
  Future<List<Pokemon>> getRangePokemons(int offset) async {
    final query = <String, String>{'offset': offset.toString(), 'limit': '20'};
    final uri = Uri.http(endPoint, '/api/v2/pokemon', query);
    return _fetchPokemonData(uri);
  }

  Future<List<Pokemon>> _fetchPokemonData(Uri uri) async {
    http.Response response;
    List body;
    try {
      response = await _httpClient.get(uri);
    } on SocketException {
      throw HttpException(message: 'No internet connection');
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
    } catch (e) {
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

class HttpException implements Exception {
  HttpException({required this.message});

  final String message;
}
