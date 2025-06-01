import 'package:collabry/core/api/end_points.dart';
import 'package:collabry/features/home_page/data/model/collaborator.dart';
import 'package:collabry/features/home_page/data/model/section.dart';

class Publication {
  String publicationId;
  String title;
  String description;
  List<dynamic> keywords;
  String language;
  String visibility;
  String status;
  List<Section>? sections;
  String categoryName;
  String categoryId;
  String authorName;
  String authorId;
  String? authorEmail;
  String? authorAvatar;
  List<Collaborator>? collaborators;
  String createdAt;
  String updatedAt;
  bool? isLiked;

  Publication({
    required this.publicationId,
    required this.title,
    required this.description,
    required this.keywords,
    required this.language,
    required this.visibility,
    required this.status,
    this.sections,
    required this.categoryName,
    required this.categoryId,
    required this.authorName,
    required this.authorId,
    this.authorEmail,
    this.authorAvatar,
    this.collaborators,
    required this.createdAt,
    required this.updatedAt,
    this.isLiked,
  });

  factory Publication.fromJson(Map<String, dynamic> json) {
    return Publication(
      publicationId: json[ApiKeys.id],
      title: json[ApiKeys.title],
      description: json[ApiKeys.abstract],
      keywords: json[ApiKeys.keywords],
      language: json[ApiKeys.language],
      visibility: json[ApiKeys.visibility],
      status: json[ApiKeys.status],
      categoryName: json[ApiKeys.categoryName],
      categoryId: json[ApiKeys.categoryId],
      authorName: json[ApiKeys.authorName],
      authorId: json[ApiKeys.authorId],
      authorAvatar: json[ApiKeys.authorAvatar],
      collaborators: (json[ApiKeys.collaborators] as List<dynamic>)
          .map((collaborator) => Collaborator.fromJson(collaborator))
          .toList(),
      createdAt: json[ApiKeys.createdAt],
      updatedAt: json[ApiKeys.updatedAt],
      isLiked: json[ApiKeys.isLiked],
    );
  }

  factory Publication.fromCategory(Map<String, dynamic> json) {
    return Publication(
      publicationId: json[ApiKeys.id],
      title: json[ApiKeys.title],
      description: json[ApiKeys.abstract],
      keywords: json[ApiKeys.keywords],
      language: json[ApiKeys.language],
      visibility: json[ApiKeys.visibility],
      status: json[ApiKeys.status],
      categoryName: json[ApiKeys.categoryName],
      categoryId: json[ApiKeys.categoryId],
      authorName: json[ApiKeys.authorName],
      authorId: json[ApiKeys.authorId],
      authorAvatar: json[ApiKeys.authorAvatar],
      createdAt: json[ApiKeys.createdAt],
      updatedAt: json[ApiKeys.updatedAt],
    );
  }

  factory Publication.fromJsonById(Map<String, dynamic> json) {
    return Publication(
      publicationId: json[ApiKeys.id],
      title: json[ApiKeys.title],
      description: json[ApiKeys.abstract],
      keywords: json[ApiKeys.keywords],
      language: json[ApiKeys.language],
      visibility: json[ApiKeys.visibility],
      status: json[ApiKeys.status],
      sections: (json[ApiKeys.sections] as List<dynamic>)
          .map((section) => Section.fromJson(section))
          .toList(),
      categoryName: json[ApiKeys.categoryName],
      categoryId: json[ApiKeys.categoryId],
      authorName: json[ApiKeys.authorName],
      authorId: json[ApiKeys.authorId],
      authorEmail: json[ApiKeys.authorEmail],
      authorAvatar: json[ApiKeys.authorAvatar],
      collaborators: (json[ApiKeys.collaborators] as List<dynamic>)
          .map((collaborator) => Collaborator.fromJson(collaborator))
          .toList(),
      createdAt: json[ApiKeys.createdAt],
      updatedAt: json[ApiKeys.updatedAt],
      isLiked: json[ApiKeys.isLiked],
    );
  }
}
