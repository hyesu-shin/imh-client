import 'package:equatable/equatable.dart';
import '../../models/record_model.dart';

abstract class RecordEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddRecordEvent extends RecordEvent {
  final RecordModel newRecord;

  AddRecordEvent(this.newRecord);

  @override
  List<Object> get props => [newRecord];
}

class LoadRecordEvent extends RecordEvent {}