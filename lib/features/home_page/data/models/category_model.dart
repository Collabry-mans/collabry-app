import 'package:collabry/core/api/end_points.dart';

class CategoryModel {
  final String id;
  final String name;

  CategoryModel({required this.id, required this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(id: json[ApiKeys.id], name: json[ApiKeys.name]);
  }
}
