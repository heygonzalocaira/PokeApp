import 'package:bloc_pokeapi/ability/cubit/pokemon_ability_cubit.dart';
import 'package:bloc_pokeapi/ability/view/ability_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_repository/poke_repository.dart';

class AbilityPage extends StatelessWidget {
  const AbilityPage({
    required this.name,
    required this.url,
    required this.index,
    super.key,
  });
  final String name;
  final String url;
  final int index;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PokemonAbilityCubit(context.read<PokeRepository>())
        ..getPokemonAbilities(index),
      child: AbilityView(name: name),
    );
  }
}
