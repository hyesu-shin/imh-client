import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'record_model.g.dart'; // 코드 자동 생성 파일

const uuid = Uuid();

@HiveType(typeId: 1)
class RecordModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String objectId;

  @HiveField(2)
  final String date;

  @HiveField(3)
  final String title;

  @HiveField(4)
  final String? description;

  @HiveField(5)
  final String status;

  RecordModel({
    String? id,
    required this.objectId,
    required this.date,
    required this.title,
    required this.description,
    required this.status,
  }) : id = id ?? uuid.v4();
}