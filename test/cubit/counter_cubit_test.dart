import 'package:bloc_test/bloc_test.dart';
import 'package:bloc_tutorial_one/cubit/counter_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CounterCubit', () {
    late CounterCubit counterCubit;

    setUpAll(() {
      counterCubit = CounterCubit();
    });

    tearDown(() {
      counterCubit.close();
    });

    test('testing if the initial state of the app is equal to 0', () {
      expect(counterCubit.state,
          CounterState(counterValue: 0, wasIncremented: false));
    });

    blocTest(
      'Testing the increment method which should return a CounterState(counterValue: 1, wasIncremented: true)',
      build: () => counterCubit,
      act: (cubit) => cubit.increment(),
      expect: () => [
        CounterState(counterValue: 1, wasIncremented: true),
      ],
    );

    blocTest(
      'Testing the decrement method which should return a CounterState(counterValue: -1, wasIncremented: false)',
      build: () => counterCubit,
      act: (cubit) => cubit.decrement(),
      expect: () => [
        CounterState(counterValue: -1, wasIncremented: false),
      ],
    );
  });
}
