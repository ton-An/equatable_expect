import 'package:equatable/equatable.dart';
import 'package:equatable_expect/src/entities/list_index.dart';
import 'package:equatable_expect/src/entities/match_failed.dart';
import 'package:flutter_test/flutter_test.dart';

void equatableExpectLogic(dynamic actual, dynamic matcher,
    [List<dynamic> history = const []]) {
  final List<dynamic> historyUpdated = List.from(history);
  historyUpdated.add(actual);

  if (actual.runtimeType == matcher.runtimeType) {
    for (int i = 0; i < actual.props.length; i++) {
      _compareProps(actual.props[i], matcher.props[i], historyUpdated);
    }
    return;
  }

  _fail(actual, matcher, history);
}

void _compareProps(
    dynamic actualProp, dynamic matcherProp, List<dynamic> history) {
  if (actualProp is List) {
    if (actualProp.length != matcherProp.length) {
      _fail(actualProp, matcherProp, history);
    }

    for (int i = 0; i < actualProp.length; i++) {
      final dynamic actualListItem = actualProp[i];
      final dynamic matcherListItem = matcherProp[i];

      final List<dynamic> historyUpdated = List.from(history);
      historyUpdated.add(ListIndex(i));

      equatableExpectLogic(actualListItem, matcherListItem, historyUpdated);
    }
    return;
  }
  if (actualProp is Equatable) {
    equatableExpectLogic(actualProp, matcherProp, history);
    return;
  }

  if (actualProp != matcherProp) {
    _fail(actualProp, matcherProp, history);
  }
}

void _fail(dynamic actualProp, dynamic matcherProp, List<dynamic> history) {
  final List<dynamic> completeTypeHistory = List.from(history);

  completeTypeHistory.add(MatchFailed(actualProp, matcherProp));

  final String errorObjectPathString = errorObjectPath(completeTypeHistory);

  expect(actualProp, matcherProp, reason: errorObjectPathString);
}

String errorObjectPath(List<dynamic> history) {
  String path = '\nPath:';

  final int historyLength = history.length;
  for (int i = 0; i < historyLength; i++) {
    final dynamic historyItem = history[i];

    if (historyItem is ListIndex) {
      path += ' List[${historyItem.index}]';
    } else if (historyItem is MatchFailed) {
      path +=
          ' ${historyItem.actual.runtimeType} (Actual) / ${historyItem.matcher.runtimeType} (Matcher)';
    } else if (i < historyLength - 1) {
      Type type = historyItem.runtimeType;
      path += ' $type ->';
    }
  }

  return path;
}
