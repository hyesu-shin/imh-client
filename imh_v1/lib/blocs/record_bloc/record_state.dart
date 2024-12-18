import 'package:equatable/equatable.dart';
import '../../models/record_model.dart';

// Base abstract class for states
abstract class RecordState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Initial state
class RecordInitial extends RecordState {}

// Loading state
class RecordLoading extends RecordState {}

// Success state with a list of Records
class RecordSuccess extends RecordState {
  final List<RecordModel> record;

  RecordSuccess({required this.record});

  @override
  List<Object?> get props => [record];
}

// Failure state with an error message
class RecordFailure extends RecordState {
  final String error;

  RecordFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
