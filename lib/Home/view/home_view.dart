import 'package:bloc_pokeapi/Home/cubit/pokemon_cubit.dart';
import 'package:bloc_pokeapi/Home/widgets/pokemon_card.dart';
import 'package:bloc_pokeapi/cubit/internet_connection_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:poke_repository/poke_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
      ),
      body: BlocBuilder<InternetConnectionCubit, InternetConnectionState>(
        builder: (context, state) {
          if (state.status == InternetStatus.noInternet) {
            return const _NoInternetView();
          } else {
            return BlocBuilder<PokemonCubit, PokemonState>(
              buildWhen: ((previous, current) {
                return current.status != PokemonStatus.loading &&
                    current.status != PokemonStatus.failureLoadMore;
              }),
              builder: (context, state) {
                switch (state.status) {
                  case PokemonStatus.initital:
                    return const _PokemonsViewInitial();
                  case PokemonStatus.sucess:
                    return _PokemonViewSuccess(pokemonlist: state.pokemons);
                  default:
                    return _PokemonViewFailure(error: state.errorMessage);
                }
              },
            );
          }
        },
      ),
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

class _PokemonViewSuccess extends StatefulWidget {
  const _PokemonViewSuccess({
    required this.pokemonlist,
    Key? key,
  }) : super(key: key);
  final List<PokemonRepository> pokemonlist;

  @override
  State<_PokemonViewSuccess> createState() => _PokemonViewSuccessState();
}

class _PokemonViewSuccessState extends State<_PokemonViewSuccess> {
  final _refreshController = RefreshController(initialRefresh: false);
  final GlobalKey _contentKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocListener<PokemonCubit, PokemonState>(
      listener: (context, state) {
        if (state.status == PokemonStatus.sucess) {
          _refreshController.loadComplete();
        }
        if (state.status == PokemonStatus.failureLoadMore) {
          _refreshController.loadFailed();
        }
      },
      child: SmartRefresher(
        controller: _refreshController,
        key: _contentKey,
        enablePullDown: false,
        enablePullUp: true,
        onLoading: () async {
          context.read<PokemonCubit>().fetchPokemons();
        },
        child: ListView.builder(
            itemCount: widget.pokemonlist.length,
            itemBuilder: ((context, index) {
              return PokemonCard(
                name: widget.pokemonlist[index].name.toUpperCase(),
                url: widget.pokemonlist[index].url,
                index: index + 1,
              );
            })),
      ),
    );
  }
}

class _PokemonViewFailure extends StatelessWidget {
  const _PokemonViewFailure({
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
