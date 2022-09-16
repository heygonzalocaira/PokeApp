import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_repository/poke_repository.dart';

class MockPokeRepository extends Mock implements PokeRepository {}

extension PumpApp on WidgetTester {
  Future<void> pumApp(
    Widget wdiget, {
    PokeRepository? pokeRepository,
  }) {
    return pumpWidget(
      RepositoryProvider.value(
        value: pokeRepository ?? MockPokeRepository(),
        child: MaterialApp(
          home: Scaffold(body: wdiget),
        ),
      ),
    );
  }
}
