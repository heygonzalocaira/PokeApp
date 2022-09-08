import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:poke_repository/poke_repository.dart';

part 'pokemon_state.dart';

class PokemonCubit extends Cubit<PokemonState> {
  PokemonCubit(this._pokemonRepository) : super(const PokemonState());
  final PokeRepository _pokemonRepository;

  void failureLoadMore(dynamic error) {
    if (state.status == PokemonStatus.loading) {
      emit(state.copyWith(
          status: PokemonStatus.failureLoadMore,
          errorMessage: error.toString()));
      return;
    }
  }

  Future<void> fetchPokemons() async {
    if (state.status != PokemonStatus.initital) {
      emit(state.copyWith(status: PokemonStatus.loading));
      return;
    }

    try {
      final pokemons = await _pokemonRepository.fetchRangePokemons();
      emit(state.copyWith(status: PokemonStatus.sucess, pokemons: pokemons));
    } on PokemonHttpException catch (error) {
      failureLoadMore(error);
      emit(state.copyWith(
          status: PokemonStatus.failure, errorMessage: error.toString()));
    } on PokemonJsonException catch (error) {
      failureLoadMore(error);
      emit(state.copyWith(
          status: PokemonStatus.failure, errorMessage: error.toString()));
    } on Exception catch (error) {
      failureLoadMore(error);
      emit(state.copyWith(
          status: PokemonStatus.failure, errorMessage: error.toString()));
    }
  }
}
