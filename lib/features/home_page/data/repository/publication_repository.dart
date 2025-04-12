import 'package:collabry/core/api/dio_consumer.dart';
import 'package:collabry/core/api/end_points.dart';
import 'package:collabry/features/home_page/data/model/publication_model.dart';
import 'package:dio/dio.dart';

abstract class PublicationRepoBase {
  Future<void> createPublication(
      String title,
      String description,
      List<String> keywords,
      String language,
      String visibility,
      String categoryId);

  Future<List<Publication>> getPublications();
  Future<List<Publication>> getPublicationsByCategory(String categoryId);
  //*-----------------------------
  Future<List<Publication>> getUserPublications();
  Future<Publication> getUserPublicationById(String userPublicationId);
  Future<Publication> getPublicationById(String publicationId);
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

  @override
  Future<List<Publication>> getPublicationsByCategory(String categoryId) async {
    final List<dynamic> publications =
        await dio.get('${EndPoints.publicationsByCategory}$categoryId');
    return publications
        .map((pub) => Publication.fromJson(pub as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<Publication> getPublicationById(String publicationId) async {
    final Response response =
        await dio.get('${EndPoints.publicationById}$publicationId');
    final publication = Publication.fromJsonById(response.data);
    return publication;
  }

  @override
  Future<Publication> getUserPublicationById(String userPublicationId) async {
    final Response response =
        await dio.get('${EndPoints.userPublicationById}$userPublicationId');
    final userPublication = Publication.fromJsonById(response.data);
    return userPublication;
  }

  @override
  Future<List<Publication>> getUserPublications() async {
    final List<dynamic> userPublications =
        await dio.get(EndPoints.userPublications);
    return userPublications.map((pub) => Publication.fromJson(pub)).toList();
  }
}
