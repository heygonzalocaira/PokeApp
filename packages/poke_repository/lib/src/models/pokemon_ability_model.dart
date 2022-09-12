import 'package:json_annotation/json_annotation.dart';

part 'pokemon_ability_model.g.dart';

@JsonSerializable()
class PokemonAbilityModel {
  PokemonAbilityModel({
    required this.name,
    required this.url,
  });

  final String name;
  final String url;
  factory PokemonAbilityModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonAbilityModelFromJson(json);
  Map<String, dynamic> toJson(PokemonAbilityModel item) =>
      _$PokemonAbilityModelToJson(this);
}
