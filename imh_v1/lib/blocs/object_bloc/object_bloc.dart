import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'object_event.dart';
import 'object_state.dart';
import '../../models/object_model.dart';

class ObjectBloc extends Bloc<ObjectEvent, ObjectState> {
  final Box<ObjectModel> objectBox;

  ObjectBloc(this.objectBox) : super(ObjectInitial()) {
    on<AddObjectEvent>((event, emit) async {
      try {
        // Hive에 새 objcet 저장
        await objectBox.add(event.newObject);

        // 상태를 갱신하여 성공적으로 저장된 데이터를 반영
        final updatedObjects = objectBox.values.toList();
        emit(ObjectSuccess(objects: updatedObjects));
      } catch (e) {
        emit(ObjectFailure(error: 'Failed to add object: $e'));
      }
    });
      
    on<LoadObjectsEvent>((event, emit) {
      // Hive에서 데이터를 불러와 상태에 반영
      final objects = objectBox.values.toList();
      emit(ObjectSuccess(objects: objects));
    });
  }
}