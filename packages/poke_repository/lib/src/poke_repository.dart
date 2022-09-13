// ignore_for_file: public_member_api_docs, join_return_with_assignment

import 'dart:async';

import 'package:poke_api/poke_api.dart';
import 'package:poke_repository/poke_repository.dart';

/// {@template poke_repository}
/// My new Flutter package
/// {@endtemplate}
class PokeRepository {
  PokeRepository({PokeApiClient? pokeApiClient})
      : _pokeApiClient = pokeApiClient ?? PokeApiClient();

  final PokeApiClient _pokeApiClient;

  List<PokemonModel> get pokemons => _pokemons;
  final List<PokemonModel> _pokemons = [];
  List<PokemonModel> get favorites => _favorites;
  final List<PokemonModel> _favorites = [];
  final _favoriteController = StreamController<List<PokemonModel>>.broadcast();
  //final List<PokemonRepository> _pokemonFavorities = [];

  Stream<List<PokemonModel>> get pokemonFavorities =>
      _favoriteController.stream.asBroadcastStream();

  void addToStream(PokemonModel item) {
    _favorites.add(item);
    print(_favorites);
    return _favoriteController.add(_favorites);
  }

  void dispose() {
    _favoriteController.close();
  }

  Future<List<PokemonModel>> fetchRangePokemons() async {
    try {
      final pokemons = await _pokeApiClient.getRangePokemons(_pokemons.length);
      final json = pokemons.map((item) => item.toJson(item)).toList();
      final listPokemons = json.map(PokemonModel.fromJson).toList();
      _pokemons.addAll(listPokemons);
    } on HttpException catch (e, stackTrace) {
      throw PokemonHttpException(e, stackTrace: stackTrace);
    } on HttpRequestFailure catch (e, stackTrace) {
      throw PokemonHttpException(e, stackTrace: stackTrace);
    } on JsonDecodeException catch (e, stackTrace) {
      throw PokemonJsonException(e, stackTrace: stackTrace);
    } on JsonDesearilizationException catch (e, stackTrace) {
      throw PokemonJsonException(e, stackTrace: stackTrace);
    }
    return _pokemons;
  }

  Future<List<PokemonAbilityModel>> fetchPokemonsAbilities(int index) async {
    try {
      final pokemons = await _pokeApiClient.getPokemonsAbilities(index);
      final json = pokemons.map((item) => item.toJson(item)).toList();
      return json.map(PokemonAbilityModel.fromJson).toList();
    } on HttpException catch (e, stackTrace) {
      throw PokemonHttpException(e, stackTrace: stackTrace);
    } on HttpRequestFailure catch (e, stackTrace) {
      throw PokemonHttpException(e, stackTrace: stackTrace);
    } on JsonDecodeException catch (e, stackTrace) {
      throw PokemonJsonException(e, stackTrace: stackTrace);
    } on JsonDesearilizationException catch (e, stackTrace) {
      throw PokemonJsonException(e, stackTrace: stackTrace);
    }
  }
}

// All exceptions
class PokemonException implements Exception {
  PokemonException(this.exception, {required this.stackTrace});

  final dynamic exception;
  final StackTrace stackTrace;
}

// Exceptions for JsonDecode or JsonSerialization fails
class PokemonJsonException extends PokemonException {
  PokemonJsonException(
    super.exception, {
    required super.stackTrace,
  });
}

// Exception for Https fails
class PokemonHttpException extends PokemonException {
  PokemonHttpException(
    super.exception, {
    required super.stackTrace,
  });
}
