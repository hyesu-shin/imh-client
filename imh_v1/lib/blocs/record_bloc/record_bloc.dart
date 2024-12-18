import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'record_event.dart';
import 'record_state.dart';
import '../../models/record_model.dart';

class RecordBloc extends Bloc<RecordEvent, RecordState> {
  final Box<RecordModel> recordsBox;

  RecordBloc(this.recordsBox) : super(RecordInitial()) {
    on<AddRecordEvent>((event, emit) async {
      try {
        // Hive에 새 objcet 저장
        await recordsBox.add(event.newRecord);

        // 상태를 갱신하여 성공적으로 저장된 데이터를 반영
        final updatedRecord = recordsBox.values.toList();
        emit(RecordSuccess(record: updatedRecord));
      } catch (e) {
        emit(RecordFailure(error: 'Failed to add record: $e'));
      }
    });
      
    on<LoadRecordEvent>((event, emit) {
      // Hive에서 데이터를 불러와 상태에 반영
      final record = recordsBox.values.toList();
      emit(RecordSuccess(record: record));
    });
  }
}