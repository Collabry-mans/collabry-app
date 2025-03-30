import 'package:collabry/core/api/end_points.dart';

class CategoryModel {
  final String id;
  final String name;
  final String? parentId;
  final String description;

  CategoryModel(
      {required this.id,
      required this.name,
      this.parentId,
      required this.description});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        id: json[ApiKeys.id],
        name: json[ApiKeys.name],
        parentId: json[ApiKeys.parentId],
        description: json[ApiKeys.description]);
  }
}
