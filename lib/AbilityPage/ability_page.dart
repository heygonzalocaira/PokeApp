import 'package:bloc_pokeapi/AbilityPage/cubit/pokemon_ability_cubit.dart';
import 'package:bloc_pokeapi/AbilityPage/view/ability_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_repository/poke_repository.dart';

class AbilityPage extends StatelessWidget {
  const AbilityPage({
    required this.name,
    required this.url,
    super.key,
  });
  final String name;
  final String url;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PokemonAbilityCubit(context.read<PokeRepository>())
        ..getPokemonAbilities(),
      child: AbilityView(name: name),
    );
  }
}
