import 'package:equatable/equatable.dart';
import '../../models/object_model.dart';

// Base abstract class for states
abstract class ObjectState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Initial state
class ObjectInitial extends ObjectState {}

// Loading state
class ObjectLoading extends ObjectState {}

// Success state with a list of objects
class ObjectSuccess extends ObjectState {
  final List<ObjectModel> object;

  ObjectSuccess({required this.object});

  @override
  List<Object?> get props => [object];
}

// Failure state with an error message
class ObjectFailure extends ObjectState {
  final String error;

  ObjectFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
