import 'package:json_annotation/json_annotation.dart';

part 'pokemon_ability_model.g.dart';

@JsonSerializable()
class PokemonAbilityModel {
  PokemonAbilityModel({
    required this.name,
    required this.url,
  });
  factory PokemonAbilityModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonAbilityModelFromJson(json);

  final String name;
  final String url;
  Map<String, dynamic> toJson(PokemonAbilityModel item) =>
      _$PokemonAbilityModelToJson(this);
}
