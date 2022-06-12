import 'package:equatable_expect/equatable_expect.dart';
import 'package:equatable_expect/src/entities/match_failed.dart';
import 'package:equatable_expect/src/equatable_expect_logic.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_classes/flat_equatable.dart';
import 'test_classes/once_nested_equatable.dart';
import 'test_classes/twice_nested_equatable.dart';
import 'test_classes/twice_nested_equatable_with_dynamic_list.dart';
import 'test_classes/twice_nested_equatable_with_list.dart';

void main() {
  const FlatEquatable tFlatEquatable = FlatEquatable('id', 'title');
  const FlatEquatable tFlatEquatable2 = FlatEquatable('id', 'titleWrong');

  const OnceNestedEquatable tOnceNestedEquatable =
      OnceNestedEquatable('id', tFlatEquatable);

  const TwiceNestedEquatable tTwiceNestedEquatable = TwiceNestedEquatable(
      'id', tFlatEquatable, OnceNestedEquatable('id', tFlatEquatable));
  const TwiceNestedEquatable tTwiceNestedEquatable2 = TwiceNestedEquatable(
      'id', tFlatEquatable, OnceNestedEquatable('id', tFlatEquatable2));

  const TwiceNestedEquatableWithList tTwiceNestedWithListEquatable =
      TwiceNestedEquatableWithList('id', tFlatEquatable, [
    OnceNestedEquatable('id', tFlatEquatable),
    OnceNestedEquatable('id', tFlatEquatable),
  ]);

  const TwiceNestedEquatableWithList tTwiceNestedWithListEquatable2 =
      TwiceNestedEquatableWithList('id', tFlatEquatable, [
    OnceNestedEquatable('id', tFlatEquatable2),
    OnceNestedEquatable('id', tFlatEquatable2),
  ]);

  const TwiceNestedEquatableWithDynamicList
      tTwiceNestedWithDynamicListEquatable =
      TwiceNestedEquatableWithDynamicList('id', tFlatEquatable, [
    OnceNestedEquatable('id', tFlatEquatable),
    OnceNestedEquatable('id', tFlatEquatable),
  ]);

  const TwiceNestedEquatableWithDynamicList
      tTwiceNestedWithDynamicListEquatable2 =
      TwiceNestedEquatableWithDynamicList('id', tFlatEquatable,
          [OnceNestedEquatable('id', tFlatEquatable), ':)']);

  group('equatableExpect()', () {
    test('should fail if objects not of same type', () {
      // assert
      expect(() => equatableExpect(tFlatEquatable, tTwiceNestedEquatable),
          throwsA(isA<TestFailure>()));
    });

    group('Flat equatable object', () {
      test('should pass test if the same', () {
        // assert
        equatableExpect(tFlatEquatable, tFlatEquatable);
      });

      test('should fail test if objects not the same', () {
        // assert
        expect(() => equatableExpect(tFlatEquatable, tFlatEquatable2),
            throwsA(isA<TestFailure>()));
      });
    });

    group('Nested equatable object', () {
      test('should pass test if the same', () {
        // assert
        equatableExpect(tTwiceNestedEquatable, tTwiceNestedEquatable);
      });

      test('should fail test if objects not the same', () {
        // assert
        expect(
            () =>
                equatableExpect(tTwiceNestedEquatable, tTwiceNestedEquatable2),
            throwsA(isA<TestFailure>()));
      });
    });

    group('Nested equatable object with list', () {
      test('should pass test if the same', () {
        // assert
        equatableExpect(
            tTwiceNestedWithListEquatable, tTwiceNestedWithListEquatable);
      });

      test('should fail test if objects not the same', () {
        // assert
        expect(
            () => equatableExpect(
                tTwiceNestedWithListEquatable, tTwiceNestedWithListEquatable2),
            throwsA(isA<TestFailure>()));
      });

      test('should fail test if objects not the same type', () {
        // assert
        expect(
            () => equatableExpect(tTwiceNestedWithDynamicListEquatable,
                tTwiceNestedWithDynamicListEquatable2),
            throwsA(isA<TestFailure>()));
      });
    });
  });

  group('errorObjectPath()', () {
    test('should output the path of the failed object', () {
      // arrange

      // act
      final result = errorObjectPath([
        tTwiceNestedEquatable2,
        tOnceNestedEquatable,
        tFlatEquatable,
        const MatchFailed('actual', 'matcher')
      ]);

      // assert
      expect(result,
          '\nPath: TwiceNestedEquatable -> OnceNestedEquatable -> FlatEquatable -> String (Actual) / String (Matcher)');
    });
  });
}
