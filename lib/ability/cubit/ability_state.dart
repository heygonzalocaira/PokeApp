part of 'ability_cubit.dart';

enum AbilityStatus { initial, sucess, loading, failure }

class AbilityState extends Equatable {
  final String errorMessage;
  final AbilityStatus status;
  final List<PokemonAbilityModel> abilities;
  final bool isFavorite;
  final String pokemonName;

  const AbilityState({
    this.errorMessage = "",
    this.status = AbilityStatus.initial,
    this.abilities = const <PokemonAbilityModel>[],
    this.isFavorite = false,
    this.pokemonName = "",
  });

  AbilityState copyWith({
    String? errorMessage,
    AbilityStatus? status,
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
