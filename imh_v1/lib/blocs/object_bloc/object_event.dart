import 'package:equatable/equatable.dart';
import '../../models/object_model.dart';

abstract class ObjectEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddObjectEvent extends ObjectEvent {
  final ObjectModel newObject;

  AddObjectEvent(this.newObject);

  @override
  List<Object> get props => [newObject];
}