import 'package:bloc_pokeapi/ability/cubit/ability_cubit.dart';
import 'package:bloc_pokeapi/ability/view/ability_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_repository/poke_repository.dart';

class AbilityPage extends StatelessWidget {
  const AbilityPage({
    required this.pokemon,
    required this.index,
    super.key,
  });
  final PokemonModel pokemon;
  final int index;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AbilityCubit(
        context.read<PokeRepository>(),
        pokemon.name,
      )..getPokemonAbilities(index),
      child: AbilityView(pokemon: pokemon),
    );
  }
}
