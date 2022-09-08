import 'package:json_annotation/json_annotation.dart';

part 'pokemon_repository.g.dart';

@JsonSerializable()
class PokemonRepository {
  const PokemonRepository({
    required this.name,
    required this.url,
  });
  final String name;
  final String url;

  factory PokemonRepository.fromJson(Map<String, dynamic> json) =>
      _$PokemonRepositoryFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonRepositoryToJson(this);
}
