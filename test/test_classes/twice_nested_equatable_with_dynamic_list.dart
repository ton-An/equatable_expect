import 'dart:ffi';

import 'package:equatable/equatable.dart';

import 'flat_equatable.dart';
import 'once_nested_equatable.dart';

class TwiceNestedEquatableWithDynamicList extends Equatable {
  final String id;
  final FlatEquatable flatEquatable;
  final List<dynamic> dynamicLists;

  const TwiceNestedEquatableWithDynamicList(
      this.id, this.flatEquatable, this.dynamicLists);

  @override
  List<Object?> get props => [id, flatEquatable, dynamicLists];
}
