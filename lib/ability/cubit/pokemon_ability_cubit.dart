import 'package:bloc/bloc.dart';
import 'package:bloc_pokeapi/cubit/internet_connection_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:poke_repository/poke_repository.dart';

part 'pokemon_ability_state.dart';

class PokemonAbilityCubit extends Cubit<PokemonAbilityState> {
  PokemonAbilityCubit(this._pokemonRepository)
      : super(const PokemonAbilityState()) {
    /*_internetConnectionChecker.onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          emit(state.copyWith(connection: true));
          break;
        case InternetConnectionStatus.disconnected:
          emit(state.copyWith(connection: false));
          break;
      }
    });*/
  }
  final PokeRepository _pokemonRepository;
  late InternetConnectionChecker _internetConnectionChecker;
  Future<void> getPokemonAbilities(int index) async {
    if (state.status != PokemonsAbilityStatus.initial) {
      emit(state.copyWith(status: PokemonsAbilityStatus.loading));
    }
    try {
      final pokemonAbilities =
          await _pokemonRepository.fetchPokemonsAbilities(index);
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
