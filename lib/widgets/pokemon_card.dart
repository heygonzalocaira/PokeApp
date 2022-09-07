import 'package:flutter/material.dart';
import 'dart:math' as math;

class PokemonCard extends StatelessWidget {
  PokemonCard({
    required this.name,
    required this.onTap,
    Key? key,
  }) : super(key: key);
  final VoidCallback onTap;
  final String name;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
            .withOpacity(1.0),
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
