import 'package:bloc_pokeapi/widgets/pokemon_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({required this.title, super.key});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
      ),
      body: ListView(
        children: [
          PokemonCard(
            name: 'Pikachu',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
