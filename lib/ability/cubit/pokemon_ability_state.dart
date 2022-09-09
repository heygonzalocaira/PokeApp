part of 'pokemon_ability_cubit.dart';

enum PokemonsAbilityStatus { initial, sucess, loading, failure }

class PokemonAbilityState extends Equatable {
  final String errorMessage;
  final PokemonsAbilityStatus status;
  final List<PokemonAbilityRepository> abilities;
  final bool connection;
  const PokemonAbilityState({
    this.errorMessage = "",
    this.status = PokemonsAbilityStatus.initial,
    this.abilities = const <PokemonAbilityRepository>[],
    this.connection = true,
  });

  PokemonAbilityState copyWith(
      {String? errorMessage,
      PokemonsAbilityStatus? status,
      List<PokemonAbilityRepository>? abilities,
      bool? connection}) {
    return PokemonAbilityState(
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      abilities: abilities ?? this.abilities,
      connection: connection ?? this.connection,
    );
  }

  @override
  List<Object?> get props => [errorMessage, status, abilities];
}
