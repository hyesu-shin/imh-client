import 'package:equatable/equatable.dart';

abstract class ObjectEvent extends Equatable {
  @override
  List <Object> get props => [];
}

class AddObjectEvent extends ObjectEvent {
  final String newObject;

  AddObjectEvent(this.newObject);

  @override
  List<Object> get props => [newObject];
}