import 'package:bloc_pokeapi/ability/view/ability_page.dart';
import 'package:flutter/material.dart';
import 'package:poke_repository/poke_repository.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({
    required this.pokemon,
    required this.index,
    Key? key,
  }) : super(key: key);
  final PokemonModel pokemon;

  final int index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AbilityPage(
              pokemon: pokemon,
              index: index,
            ),
          ),
        );
      },
      child: Card(
        color: Colors.green[300],
        elevation: 1,
        child: SizedBox(
          height: 50,
          child: Center(
            child: Text(pokemon.name.toUpperCase()),
          ),
        ),
      ),
    );
  }
}
