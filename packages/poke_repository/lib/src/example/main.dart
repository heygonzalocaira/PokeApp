import 'package:poke_repository/poke_repository.dart';

void main() async {
  final pokeRepository = PokeRepository();
  try {
    final pokemons = await pokeRepository.fetchPokemonsAbilities(1);
    for (final pokemon in pokemons) {
      print(pokemon.name);
    }
  } catch (e) {
    print(e);
  }
}
