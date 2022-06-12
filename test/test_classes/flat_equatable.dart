import 'package:equatable/equatable.dart';

/// Example of a flat [Equatable] class
class FlatEquatable extends Equatable {
  final String id;
  final String title;

  const FlatEquatable(this.id, this.title);

  @override
  List<Object?> get props => [id, title];
}
