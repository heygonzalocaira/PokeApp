import 'package:bloc_pokeapi/ability/ability.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_repository/poke_repository.dart';

class MockPokeRepository extends Mock implements PokeRepository {}

class MockAbilityCubit extends MockBloc<AbilityCubit, AbilityState>
    implements AbilityCubit {}

class MockPokemonModel extends Mock implements PokemonModel {}

void main() {
  late AbilityCubit mockAbilityCubit;
  late PokeRepository mockPokeRepository;
  late PokemonModel mockPokemonModel;
  group("Ability page UI - ", () {
    setUp(() {
      mockPokeRepository = MockPokeRepository();
      mockAbilityCubit = MockAbilityCubit();
      mockPokemonModel = MockPokemonModel();
    });
/*
    testWidgets("1 - Favorite icon is paint", (tester) async {
      when(() => mockAbilityCubit.state).thenReturn(
        const AbilityState(
          status: AbilityStatus.sucess,
          //isFavorite: true,
        ),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: AbilityView(
            pokemon: mockPokemonModel,
          ),
        ),
      );
      expect(find.byType(PokemonAbilityViewSucess), findsOneWidget);
    });*/
  });
}
