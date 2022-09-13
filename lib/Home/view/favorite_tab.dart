import 'package:bloc_pokeapi/home/cubit/home_cubit.dart';
import 'package:bloc_pokeapi/home/widgets/favorite_pokemon.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.favorities.isEmpty) {
          return const Center(child: Text("No favorites"));
        }
        return ListView.builder(
          itemCount: state.favorities.length,
          itemBuilder: (context, index) =>
              FavoritePokemon(pokemon: state.favorities[index]),
        );
      },
    );
  }
}
