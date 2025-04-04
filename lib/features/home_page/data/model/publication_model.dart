import 'package:collabry/core/api/end_points.dart';

class Publication {
  String id;
  String title;
  String description;
  List<dynamic> keywords;
  String language;
  String visibility;
  List<dynamic> sections;
  String categoryName;
  String categoryId;
  String authorName;
  String authorId;
  List<dynamic> collaborators;
  String createdAt;

  Publication({
    required this.id,
    required this.title,
    required this.description,
    required this.keywords,
    required this.language,
    required this.visibility,
    required this.sections,
    required this.categoryName,
    required this.categoryId,
    required this.authorName,
    required this.authorId,
    required this.collaborators,
    required this.createdAt,
  });

  factory Publication.fromJson(Map<String, dynamic> json) {
    return Publication(
        id: json[ApiKeys.id],
        title: json[ApiKeys.title],
        description: json[ApiKeys.abstract],
        keywords: json[ApiKeys.keywords],
        language: json[ApiKeys.language],
        visibility: json[ApiKeys.visibility],
        sections: json[ApiKeys.sections],
        categoryName: json[ApiKeys.categoryName],
        categoryId: json[ApiKeys.categoryId],
        authorName: json[ApiKeys.authorName],
        authorId: json[ApiKeys.authorId],
        collaborators: json[ApiKeys.collaborators],
        createdAt: json[ApiKeys.createdAt]);
  }
}
