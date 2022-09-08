import 'package:poke_api/poke_api.dart';

void main() async {
  final pokeApiClient = PokeApiClient();

  try {
    final pokemons = await pokeApiClient.getRangePokemons(20);
    for (final pokemon in pokemons) {
      print(pokemon.name);
    }
  } on Exception catch (e) {
    print(e);
  }
}
