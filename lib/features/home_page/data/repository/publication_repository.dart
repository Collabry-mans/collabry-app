import 'package:collabry/core/api/dio_consumer.dart';
import 'package:collabry/core/api/end_points.dart';
import 'package:collabry/features/home_page/data/models/publication_model.dart';
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
  Future<void> changePublicationStatus(String publicationId, String status);
  Future<Publication> changePublicationData(
      String publicationId,
      String? title,
      String? description,
      String? language,
      String? visibility,
      String? categoryId,
      List<String?>? keywords);
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
        .map((pub) => Publication.fromCategory(pub as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<Publication> getPublicationById(String publicationId) async {
    final Map<String, dynamic> response =
        await dio.get('${EndPoints.publicationById}$publicationId');
    final publication = Publication.fromJsonById(response);
    return publication;
  }

  @override
  Future<Publication> getUserPublicationById(String userPublicationId) async {
    final Map<String, dynamic> response =
        await dio.get('${EndPoints.userPublicationById}$userPublicationId');
    final userPublication = Publication.fromJsonById(response);
    return userPublication;
  }

  @override
  Future<List<Publication>> getUserPublications() async {
    final List<dynamic> userPublications =
        await dio.get(EndPoints.userPublications);
    return userPublications.map((pub) => Publication.fromJson(pub)).toList();
  }

  @override
  Future<void> changePublicationStatus(
      String publicationId, String status) async {
    await dio.patch('${EndPoints.userPublicationStatus}$publicationId',
        queryParameters: {ApiKeys.id: publicationId},
        data: {ApiKeys.type: status});
  }

  @override
  Future<Publication> changePublicationData(
      String publicationId,
      String? title,
      String? description,
      String? language,
      String? visibility,
      String? categoryId,
      List<String?>? keywords) async {
    final Response response =
        await dio.put('${EndPoints.userPublicationById}$publicationId', data: {
      ApiKeys.title: title,
      ApiKeys.abstract: description,
      ApiKeys.keywords: keywords,
      ApiKeys.language: language,
      ApiKeys.visibility: visibility,
      ApiKeys.categoryId: categoryId,
    });
    final editedPublication = Publication.fromJsonById(response.data);
    return editedPublication;
  }
}
