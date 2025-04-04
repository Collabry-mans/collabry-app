import 'package:collabry/core/api/dio_consumer.dart';
import 'package:collabry/core/api/end_points.dart';
import 'package:collabry/features/home_page/data/model/publication_model.dart';

abstract class PublicationRepoBase {
  Future<void> createPublication(
      String title,
      String description,
      List<String> keywords,
      String language,
      String visibility,
      String categoryId);

  Future<List<Publication>> getPublications();
}

class PublicationRepo implements PublicationRepoBase {
  final DioConsumer dio;
  PublicationRepo({required this.dio});

  @override
  Future<void> createPublication(
      String title,
      String description,
      List<String> keywords,
      String language,
      String visibility,
      String categoryId) async {
    await dio.post(
      EndPoints.publicationsCreate,
      data: {
        ApiKeys.title: title,
        ApiKeys.abstract: description,
        ApiKeys.keywords: keywords,
        ApiKeys.language: language,
        ApiKeys.visibility: visibility,
        ApiKeys.categoryId: categoryId,
      },
    );
  }

  @override
  Future<List<Publication>> getPublications() async {
    final List<dynamic> publications = await dio.get(EndPoints.publications);
    final List<Publication> publicationsList = publications
        .map((publication) => Publication.fromJson(publication))
        .toList();
    return publicationsList;
  }
}
