import 'package:json_annotation/json_annotation.dart';

part 'pokemon_ability_repository.g.dart';

@JsonSerializable()
class PokemonAbilityRepository {
  PokemonAbilityRepository({
    required this.name,
    required this.url,
  });

  final String name;
  final String url;
  factory PokemonAbilityRepository.fromJson(Map<String, dynamic> json) =>
      _$PokemonAbilityRepositoryFromJson(json);
  Map<String, dynamic> toJson(PokemonAbilityRepository item) =>
      _$PokemonAbilityRepositoryToJson(this);
}
