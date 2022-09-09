import 'package:poke_repository/poke_repository.dart';

void main() async {
  final pokeRepository = PokeRepository();
  try {
    final pokemons = await pokeRepository.fetchPokemonsAbilities();
    for (final pokemon in pokemons) {
      print(pokemon.name);
    }
  } catch (e) {
    print(e);
  }
}
