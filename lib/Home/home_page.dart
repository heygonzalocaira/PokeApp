import 'package:bloc_pokeapi/Home/cubit/pokemon_cubit.dart';
import 'package:bloc_pokeapi/Home/view/home_view.dart';
import 'package:bloc_pokeapi/cubit/internet_connection_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:poke_repository/poke_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({required this.title, super.key});
  final String title;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              PokemonCubit(context.read<PokeRepository>())..fetchPokemons(),
        ),
        BlocProvider(
          create: (context) =>
              InternetConnectionCubit(InternetConnectionChecker())
                ..monitorInternet(),
        ),
      ],
      child: HomeView(title: title),
    );
  }
}
