import 'package:bloc_pokeapi/home/cubit/home_cubit.dart';
import 'package:bloc_pokeapi/home/view/favorite_tab.dart';
import 'package:bloc_pokeapi/home/view/pokemon_list_tab.dart';
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
          HomeCubit(context.read<PokeRepository>())..fetchPokemons(),
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(title),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Pokemon list"),
              Tab(text: "Favorites"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PokemonListTab(),
            FavoriteTab(),
          ],
        ),
      ),
    );
  }
}
