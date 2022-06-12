import 'package:equatable/equatable.dart';

import 'flat_equatable.dart';

class OnceNestedEquatable extends Equatable {
  final String id;
  final FlatEquatable flatEquatable;

  const OnceNestedEquatable(this.id, this.flatEquatable);

  @override
  List<Object?> get props => [id, flatEquatable];
}
