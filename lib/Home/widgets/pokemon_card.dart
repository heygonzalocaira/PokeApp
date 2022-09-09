import 'package:bloc_pokeapi/ability/ability_page.dart';
import 'package:flutter/material.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({
    required this.name,
    required this.url,
    required this.index,
    Key? key,
  }) : super(key: key);
  final String name;
  final String url;
  final int index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AbilityPage(
              name: name,
              url: url,
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
            child: Text(name),
          ),
        ),
      ),
    );
  }
}
