import 'package:poke_api/poke_api.dart';

void main() async {
  final pokeApiClient = PokeApiClient();

  try {
    final pokemonsAbilities = await pokeApiClient.getPokemonsAbilities(20);
    for (final pokemonAbility in pokemonsAbilities) {
      print(pokemonAbility.name);
    }
  } on Exception catch (e) {
    print(e);
  }
}
