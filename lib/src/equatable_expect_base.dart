library equatable_expect;

import 'package:equatable/equatable.dart';
import 'package:equatable_expect/src/equatable_expect_logic.dart';

void equatableExpect(Equatable actual, Equatable matcher) {
  equatableExpectLogic(actual, matcher);
}
