// ignore_for_file: public_member_api_docs, join_return_with_assignment

import 'package:poke_api/poke_api.dart';
import 'package:poke_repository/poke_repository.dart';

/// {@template poke_repository}
/// My new Flutter package
/// {@endtemplate}
class PokeRepository {
  PokeRepository({PokeApiClient? pokeApiClient})
      : _pokeApiClient = pokeApiClient ?? PokeApiClient();

  final PokeApiClient _pokeApiClient;

  List<PokemonRepository> get pokemons => _pokemons;
  List<PokemonRepository> _pokemons = [];

  Future<List<PokemonRepository>> fetchRangePokemons() async {
    try {
      final pokemons = await _pokeApiClient.getRangePokemons(_pokemons.length);
      final json = pokemons.map((item) => item.toJson(item)).toList();
      _pokemons = [
        ..._pokemons,
        ...json.map(PokemonRepository.fromJson).toList()
      ];
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
