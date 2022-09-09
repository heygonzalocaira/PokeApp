part of 'pokemon_ability_cubit.dart';

enum PokemonsAbilityStatus { initial, sucess, loading, failure }

class PokemonAbilityState extends Equatable {
  final String errorMessage;
  final PokemonsAbilityStatus status;
  final List<PokemonAbilityRepository> abilities;

  const PokemonAbilityState({
    this.errorMessage = "",
    this.status = PokemonsAbilityStatus.initial,
    this.abilities = const <PokemonAbilityRepository>[],
  });

  PokemonAbilityState copyWith(
      {String? errorMessage,
      PokemonsAbilityStatus? status,
      List<PokemonAbilityRepository>? abilities}) {
    return PokemonAbilityState(
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      abilities: abilities ?? this.abilities,
    );
  }

  @override
  List<Object?> get props => [errorMessage, status, abilities];
}
