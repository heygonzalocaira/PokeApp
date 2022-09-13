import 'package:bloc_pokeapi/ability/cubit/ability_cubit.dart';
import 'package:bloc_pokeapi/ability/widgets/pokemon_ability_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_repository/poke_repository.dart';

class AbilityView extends StatelessWidget {
  const AbilityView({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final PokemonModel pokemon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name),
        centerTitle: true,
        actions: [
          BlocBuilder<AbilityCubit, AbilityState>(
            builder: (context, state) {
              return IconButton(
                icon: state.isFavorite == false
                    ? const Icon(Icons.favorite_border)
                    : const Icon(Icons.favorite),
                onPressed: () {
                  if (!state.isFavorite) {
                    context.read<AbilityCubit>().addFavoritePokemon(pokemon);
                  } else {
                    context.read<AbilityCubit>().remoteFavoritePokemon(pokemon);
                  }
                },
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<AbilityCubit, AbilityState>(
        builder: (context, state) {
          switch (state.status) {
            case PokemonsAbilityStatus.initial:
              return const _PokemonsAbilityViewInitial();
            case PokemonsAbilityStatus.sucess:
              return _PokemonAbilityViewSucess(abilities: state.abilities);

            default:
              return _PokemonsAbilityViewFailure(error: state.errorMessage);
          }
        },
      ),
    );
  }
}

class _PokemonAbilityViewSucess extends StatelessWidget {
  const _PokemonAbilityViewSucess({
    required this.abilities,
    Key? key,
  }) : super(key: key);
  final List<PokemonAbilityModel> abilities;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: abilities.length,
      itemBuilder: (context, index) {
        return PokemonAbilityCard(
          index: index,
          ability: abilities[index].name,
        );
      },
    );
  }
}

class _PokemonsAbilityViewFailure extends StatelessWidget {
  const _PokemonsAbilityViewFailure({
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
          Icons.dnd_forwardslash_outlined,
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

class _PokemonsAbilityViewInitial extends StatelessWidget {
  const _PokemonsAbilityViewInitial({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
