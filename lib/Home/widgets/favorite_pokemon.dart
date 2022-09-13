import 'package:flutter/material.dart';
import 'package:poke_repository/poke_repository.dart';

class FavoritePokemon extends StatelessWidget {
  const FavoritePokemon({required this.pokemon, super.key});

  final PokemonModel pokemon;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.yellow[300],
      elevation: 1,
      child: SizedBox(
        height: 50,
        child: Center(
          child: Text(pokemon.name.toUpperCase()),
        ),
      ),
    );
  }
}
