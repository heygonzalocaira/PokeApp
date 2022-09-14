part of 'home_cubit.dart';

enum HomeStatus {
  initital,
  loading,
  sucess,
  failure,
  failureLoadMore,
}

class HomeState extends Equatable {
  final String errorMessage;
  final HomeStatus status;
  final List<PokemonModel> pokemons;
  final List<PokemonModel> favorities;

  const HomeState({
    this.errorMessage = "",
    this.status = HomeStatus.initital,
    this.pokemons = const <PokemonModel>[],
    this.favorities = const <PokemonModel>[],
  });

  HomeState copyWith({
    String? errorMessage,
    HomeStatus? status,
    List<PokemonModel>? pokemons,
    List<PokemonModel>? favorities,
  }) {
    return HomeState(
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      pokemons: pokemons ?? this.pokemons,
      favorities: favorities ?? this.favorities,
    );
  }

  @override
  List<Object?> get props => [errorMessage, status, pokemons, favorities];
}
