import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:poke_repository/poke_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._pokemonRepository) : super(const HomeState()) {
    _pokemonRepository.pokemonFavorities.listen((favorities) {
      emit(state.copyWith(favorities: favorities));
    });
  }
  final PokeRepository _pokemonRepository;

  void _failureLoadMore(dynamic error) {
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
    }
    try {
      final pokemons = await _pokemonRepository.fetchRangePokemons();
      emit(state.copyWith(status: PokemonStatus.sucess, pokemons: pokemons));
    } on PokemonHttpException catch (error) {
      _failureLoadMore(error);
      emit(state.copyWith(
          status: PokemonStatus.failure, errorMessage: error.toString()));
    } on PokemonJsonException catch (error) {
      _failureLoadMore(error);
      emit(state.copyWith(
          status: PokemonStatus.failure, errorMessage: error.toString()));
    } on Exception catch (error) {
      _failureLoadMore(error);
      emit(state.copyWith(
          status: PokemonStatus.failure, errorMessage: error.toString()));
    }
  }
}
