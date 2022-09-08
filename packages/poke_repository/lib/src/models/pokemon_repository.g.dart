// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonRepository _$PokemonRepositoryFromJson(Map<String, dynamic> json) =>
    PokemonRepository(
      name: json['name'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$PokemonRepositoryToJson(PokemonRepository instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };
