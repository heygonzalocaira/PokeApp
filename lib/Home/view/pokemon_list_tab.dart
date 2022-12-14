import 'package:bloc_pokeapi/home/cubit/home_cubit.dart';
import 'package:bloc_pokeapi/home/widgets/pokemon_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_repository/poke_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PokemonListTab extends StatelessWidget {
  const PokemonListTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: ((previous, current) {
        return current.status != HomeStatus.loading &&
            current.status != HomeStatus.failureLoadMore;
      }),
      builder: (context, state) {
        switch (state.status) {
          case HomeStatus.initital:
            return const _PokemonsViewInitial();
          case HomeStatus.sucess:
            return PokemonViewSuccess(pokemonlist: state.pokemons);
          default:
            return PokemonViewFailure(error: state.errorMessage);
        }
      },
    );
  }
}

class _NoInternetView extends StatelessWidget {
  const _NoInternetView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Internet disconnected"));
  }
}

class PokemonViewSuccess extends StatefulWidget {
  const PokemonViewSuccess({
    required this.pokemonlist,
    Key? key,
  }) : super(key: key);
  final List<PokemonModel> pokemonlist;

  @override
  State<PokemonViewSuccess> createState() => PokemonViewSuccessState();
}

class PokemonViewSuccessState extends State<PokemonViewSuccess> {
  final _refreshController = RefreshController(initialRefresh: false);
  final GlobalKey _contentKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state.status == HomeStatus.sucess) {
          _refreshController.loadComplete();
        }
        if (state.status == HomeStatus.failureLoadMore) {
          _refreshController.loadFailed();
        }
      },
      child: SmartRefresher(
        controller: _refreshController,
        key: _contentKey,
        enablePullDown: false,
        enablePullUp: true,
        onLoading: () async {
          context.read<HomeCubit>().fetchPokemons();
        },
        child: ListView.builder(
            itemCount: widget.pokemonlist.length,
            itemBuilder: ((context, index) {
              return PokemonCard(
                pokemon: widget.pokemonlist[index],
                index: index + 1,
              );
            })),
      ),
    );
  }
}

class PokemonViewFailure extends StatelessWidget {
  const PokemonViewFailure({
    required this.error,
    Key? key,
  }) : super(key: key);
  final String error;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.sms_failed_rounded,
          size: 60,
        ),
        const Text("Ups"),
        Center(
          child: Text(error),
        ),
      ],
    );
  }
}

class _PokemonsViewInitial extends StatelessWidget {
  const _PokemonsViewInitial({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
