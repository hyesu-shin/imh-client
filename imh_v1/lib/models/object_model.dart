class ObjectModel {
  final String name;
  final String description;
  final String startDate;
  final String? option;
  final List<Map<String, String>> dynamicFields;

  ObjectModel({
    required this.name,
    required this.description,
    required this.startDate,
    this.option,
    required this.dynamicFields,
  });
}