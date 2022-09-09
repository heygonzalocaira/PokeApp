import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:poke_repository/poke_repository.dart';

part 'pokemon_ability_state.dart';

class PokemonAbilityCubit extends Cubit<PokemonAbilityState> {
  PokemonAbilityCubit(this._pokemonRepository)
      : super(const PokemonAbilityState());
  final PokeRepository _pokemonRepository;

  Future<void> getPokemonAbilities() async {
    if (state.status != PokemonsAbilityStatus.initial) {
      emit(state.copyWith(status: PokemonsAbilityStatus.loading));
    }
    try {
      final pokemonAbilities =
          await _pokemonRepository.fetchPokemonsAbilities();
      emit(state.copyWith(
          status: PokemonsAbilityStatus.sucess, abilities: pokemonAbilities));
    } on PokemonHttpException catch (e) {
      emit(state.copyWith(
          errorMessage: e.toString(), status: PokemonsAbilityStatus.failure));
    } on PokemonJsonException catch (e) {
      emit(state.copyWith(
          errorMessage: e.toString(), status: PokemonsAbilityStatus.failure));
    } on Exception catch (e) {
      emit(state.copyWith(
          errorMessage: e.toString(), status: PokemonsAbilityStatus.failure));
    }
  }
}
