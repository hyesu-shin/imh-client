import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'object_model.g.dart'; // 코드 자동 생성 파일

const uuid = Uuid();

@HiveType(typeId: 0)
class ObjectModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final DateTime startDate;

  @HiveField(4)
  final DateTime? endDate;

  @HiveField(5)
  final List<Map<String, String>> dynamicFields;

  ObjectModel({
    String? id,
    required this.name,
    required this.description,
    required this.startDate,
    this.endDate,
    required this.dynamicFields,
  }) : id = id ?? uuid.v4();
}