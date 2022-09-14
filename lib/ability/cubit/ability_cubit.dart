import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:poke_repository/poke_repository.dart';

part 'ability_state.dart';

class AbilityCubit extends Cubit<AbilityState> {
  AbilityCubit(this._pokemonRepository, pokemonName)
      : super(AbilityState(pokemonName: pokemonName)) {
    bool foundFavorite = false;
    for (final favorite in _pokemonRepository.favorites) {
      if (favorite.name == state.pokemonName) {
        emit(state.copyWith(isFavorite: true));
        foundFavorite = true;
      }
    }
    if (foundFavorite == false) {
      emit(state.copyWith(isFavorite: false));
    }
    _pokemonRepository.pokemonFavorities.listen((favorities) {
      for (final favorite in favorities) {
        if (favorite.name == state.pokemonName) {
          emit(state.copyWith(isFavorite: true));
          return;
        }
      }
      emit(state.copyWith(isFavorite: false));
    });
  }
  final PokeRepository _pokemonRepository;

  void addFavoritePokemon(PokemonModel pokemon) {
    _pokemonRepository.addToFavorites(pokemon);
  }

  void remoteFavoritePokemon(PokemonModel pokemon) {
    _pokemonRepository.remoteFromFavorites(pokemon);
  }

  Future<void> getPokemonAbilities(int index) async {
    if (state.status != AbilityStatus.initial) {
      emit(state.copyWith(status: AbilityStatus.loading));
    }
    try {
      final pokemonAbilities =
          await _pokemonRepository.fetchPokemonsAbilities(index);
      emit(state.copyWith(
          status: AbilityStatus.sucess, abilities: pokemonAbilities));
    } on PokemonHttpException catch (e) {
      emit(state.copyWith(
          errorMessage: e.toString(), status: AbilityStatus.failure));
    } on PokemonJsonException catch (e) {
      emit(state.copyWith(
          errorMessage: e.toString(), status: AbilityStatus.failure));
    } on Exception catch (e) {
      emit(state.copyWith(
          errorMessage: e.toString(), status: AbilityStatus.failure));
    }
  }
}
