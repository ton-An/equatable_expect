import 'package:equatable/equatable.dart';

import 'flat_equatable.dart';
import 'once_nested_equatable.dart';

class TwiceNestedEquatableWithList extends Equatable {
  final String id;
  final FlatEquatable flatEquatable;
  final List<OnceNestedEquatable> onceNestedEquatableList;

  const TwiceNestedEquatableWithList(
      this.id, this.flatEquatable, this.onceNestedEquatableList);

  @override
  List<Object?> get props => [id, flatEquatable, onceNestedEquatableList];
}
