// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:poke_repository/poke_repository.dart';

void main() {
  group('PokeRepository', () {
    test('can be instantiated', () {
      expect(PokeRepository(), isNotNull);
    });
  });
}
