import 'package:json_annotation/json_annotation.dart';

part 'pokemon.g.dart';

@JsonSerializable()
class Pokemon {
  const Pokemon({
    required this.name,
    required this.url,
  });
  final String name;
  final String url;

  factory Pokemon.fromJson(Map<String, dynamic> json) =>
      _$PokemonFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonToJson(this);

  toList() {}
}
