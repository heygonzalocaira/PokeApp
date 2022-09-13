part of 'ability_cubit.dart';

enum PokemonsAbilityStatus { initial, sucess, loading, failure }

class AbilityState extends Equatable {
  final String errorMessage;
  final PokemonsAbilityStatus status;
  final List<PokemonAbilityModel> abilities;
  final bool isFavorite;
  final String pokemonName;

  const AbilityState({
    this.errorMessage = "",
    this.status = PokemonsAbilityStatus.initial,
    this.abilities = const <PokemonAbilityModel>[],
    this.isFavorite = false,
    this.pokemonName = "",
  });

  AbilityState copyWith({
    String? errorMessage,
    PokemonsAbilityStatus? status,
    List<PokemonAbilityModel>? abilities,
    bool? isFavorite,
    String? pokemonName,
  }) {
    return AbilityState(
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      abilities: abilities ?? this.abilities,
      isFavorite: isFavorite ?? this.isFavorite,
      pokemonName: pokemonName ?? this.pokemonName,
    );
  }

  @override
  List<Object?> get props => [
        errorMessage,
        status,
        abilities,
        isFavorite,
        pokemonName,
      ];
}
