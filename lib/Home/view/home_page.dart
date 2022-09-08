import 'package:bloc_pokeapi/Home/cubit/pokemon_cubit.dart';
import 'package:bloc_pokeapi/Home/widgets/pokemon_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_repository/poke_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({required this.title, super.key});
  final String title;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PokemonCubit(context.read<PokeRepository>())..fetchPokemons(),
      child: HomeView(title: title),
    );
  }
}

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
      body: BlocBuilder<PokemonCubit, PokemonState>(
        //buildWhen: ((previous, current) {
        //  return current.status != PokemonStatus.loading;
        //}),
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
      ),
    );
  }
}

class _PokemonViewSuccess extends StatelessWidget {
  const _PokemonViewSuccess({
    required this.pokemonlist,
    Key? key,
  }) : super(key: key);
  final List<PokemonRepository> pokemonlist;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: pokemonlist.length,
        itemBuilder: ((context, index) {
          return PokemonCard(name: '# $index ${pokemonlist[index].name}');
        }));
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
    return Center(
      child: Text(error),
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
