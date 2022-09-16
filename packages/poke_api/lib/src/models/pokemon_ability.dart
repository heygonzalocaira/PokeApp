import 'package:json_annotation/json_annotation.dart';

part 'pokemon_ability.g.dart';

@JsonSerializable()
class PokemonAbility {
  PokemonAbility({
    required this.name,
    required this.url,
  });
  factory PokemonAbility.fromJson(Map<String, dynamic> json) =>
      _$PokemonAbilityFromJson(json);

  final String name;
  final String url;
  Map<String, dynamic> toJson(PokemonAbility item) =>
      _$PokemonAbilityToJson(this);
}
