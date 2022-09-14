import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:poke_repository/poke_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._pokemonRepository) : super(const HomeState()) {
    _favoritesSuscription =
        _pokemonRepository.pokemonFavorities.listen((favorities) {
      emit(state.copyWith(favorities: favorities));
    });
  }
  final PokeRepository _pokemonRepository;
  late StreamSubscription<List<PokemonModel>> _favoritesSuscription;
  void _failureLoadMore(dynamic error) {
    if (state.status == HomeStatus.loading) {
      emit(state.copyWith(
          status: HomeStatus.failureLoadMore, errorMessage: error.toString()));
      return;
    }
  }

  Future<void> fetchPokemons() async {
    if (state.status != HomeStatus.initital) {
      emit(state.copyWith(status: HomeStatus.loading));
    }
    try {
      final pokemons = await _pokemonRepository.fetchRangePokemons();
      emit(state.copyWith(status: HomeStatus.sucess, pokemons: pokemons));
    } on PokemonHttpException catch (error) {
      _failureLoadMore(error);
      emit(state.copyWith(
          status: HomeStatus.failure, errorMessage: error.toString()));
    } on PokemonJsonException catch (error) {
      _failureLoadMore(error);
      emit(state.copyWith(
          status: HomeStatus.failure, errorMessage: error.toString()));
    } on Exception catch (error) {
      _failureLoadMore(error);
      emit(state.copyWith(
          status: HomeStatus.failure, errorMessage: error.toString()));
    }
  }

  @override
  Future<void> close() {
    _favoritesSuscription.cancel();
    return super.close();
  }
}
