import 'package:hive/hive.dart';

part 'object_model.g.dart'; // 코드 자동 생성 파일

@HiveType(typeId: 0)
class ObjectModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final String startDate;

  @HiveField(3)
  final String? option;

  @HiveField(4)
  final List<Map<String, String>> dynamicFields;

  ObjectModel({
    required this.name,
    required this.description,
    required this.startDate,
    this.option,
    required this.dynamicFields,
  });
}