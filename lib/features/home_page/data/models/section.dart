import 'package:collabry/core/api/end_points.dart';

class Section {
  String title;
  String orderIndex;
  String type;
  String content;
  List<String> files;
  String publicationId;
  Section(
      {required this.title,
      required this.content,
      required this.orderIndex,
      required this.type,
      required this.files,
      required this.publicationId});

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
        title: json[ApiKeys.title],
        content: json[ApiKeys.content],
        orderIndex: json[ApiKeys.orderIndex],
        type: json[ApiKeys.type],
        files: json[ApiKeys.files],
        publicationId: json[ApiKeys.publicationId]);
  }
}
