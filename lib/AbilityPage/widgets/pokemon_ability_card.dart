import 'package:flutter/material.dart';

class PokemonAbilityCard extends StatelessWidget {
  const PokemonAbilityCard({
    Key? key,
    required this.index,
    required this.ability,
  }) : super(key: key);
  final int index;
  final String ability;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: SizedBox(
        height: 80,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Habilidad #$index",
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                "- $ability",
                style: const TextStyle(fontSize: 30),
              )
            ],
          ),
        ),
      ),
    );
  }
}
