part of 'pokemon_cubit.dart';

enum PokemonStatus {
  initital,
  loading,
  sucess,
  failure,
  failureLoadMore,
}

class PokemonState extends Equatable {
  final String errorMessage;
  final PokemonStatus status;
  final List<PokemonRepository> pokemons;

  const PokemonState({
    this.errorMessage = "",
    this.status = PokemonStatus.initital,
    this.pokemons = const <PokemonRepository>[],
  });

  PokemonState copyWith({
    String? errorMessage,
    PokemonStatus? status,
    List<PokemonRepository>? pokemons,
  }) {
    return PokemonState(
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      pokemons: pokemons ?? this.pokemons,
    );
  }

  @override
  List<Object?> get props => [errorMessage, status, pokemons];
}
