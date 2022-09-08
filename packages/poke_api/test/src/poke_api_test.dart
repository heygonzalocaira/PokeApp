// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:poke_api/poke_api.dart';

void main() {
  group('PokeApi', () {
    test('can be instantiated', () {
      expect(PokeApiClient(), isNotNull);
    });
  });
}
