import 'package:equatable/equatable.dart';

import 'flat_equatable.dart';
import 'once_nested_equatable.dart';

class TwiceNestedEquatable extends Equatable {
  final String id;
  final FlatEquatable flatEquatable;
  final OnceNestedEquatable onceNestedEquatable;

  const TwiceNestedEquatable(
      this.id, this.flatEquatable, this.onceNestedEquatable);

  @override
  List<Object?> get props => [id, flatEquatable, onceNestedEquatable];
}
