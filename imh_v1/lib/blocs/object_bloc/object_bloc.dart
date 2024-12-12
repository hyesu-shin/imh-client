import 'package:flutter_bloc/flutter_bloc.dart';
import 'object_event.dart';
import 'object_state.dart';

class ObjectBloc extends Bloc<ObjectEvent, ObjectState> {
  ObjectBloc() : super(ObjectInitial()) {
    on<AddObjectEvent>((event, emit) {
      if (state is ObjectSuccess) {
        final updatedObjects = List<String>.from((state as ObjectSuccess).objects)
          ..add(event.newObject);
        emit(ObjectSuccess(objects: updatedObjects));
      } else {
        emit(ObjectSuccess(objects: [event.newObject])); // Initialize with the new object
      }
    });
  }
}