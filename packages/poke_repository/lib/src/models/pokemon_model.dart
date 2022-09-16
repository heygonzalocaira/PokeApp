import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pokemon_model.g.dart';

@JsonSerializable()
class PokemonModel extends Equatable {
  const PokemonModel({
    required this.name,
    required this.url,
  });
  factory PokemonModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonModelFromJson(json);
  final String name;
  final String url;
  Map<String, dynamic> toJson() => _$PokemonModelToJson(this);

  @override
  List<Object?> get props => [name, url];
}
