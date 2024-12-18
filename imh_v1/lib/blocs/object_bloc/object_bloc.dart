import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'object_event.dart';
import 'object_state.dart';
import '../../models/object_model.dart';

class ObjectBloc extends Bloc<ObjectEvent, ObjectState> {
  final Box<ObjectModel> objectsBox;

  ObjectBloc(this.objectsBox) : super(ObjectInitial()) {
    on<AddObjectEvent>((event, emit) async {
      try {
        // Hive에 새 objcet 저장
        await objectsBox.add(event.newObject);

        // 상태를 갱신하여 성공적으로 저장된 데이터를 반영
        final updatedObjects = objectsBox.values.toList();
        emit(ObjectSuccess(object: updatedObjects));
      } catch (e) {
        emit(ObjectFailure(error: 'Failed to add object: $e'));
      }
    });
      
    on<LoadObjectEvent>((event, emit) {
      // Hive에서 데이터를 불러와 상태에 반영
      final object = objectsBox.values.toList();
      emit(ObjectSuccess(object: object));
    });
  }
}