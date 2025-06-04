import 'package:collabry/core/api/dio_consumer.dart';
import 'package:collabry/core/api/end_points.dart';
import 'package:collabry/core/api/networking/api_error_handler.dart';
import 'package:collabry/core/api/networking/api_result.dart';
import 'package:collabry/features/home_page/data/models/publication_model.dart';
import 'package:dio/dio.dart';

abstract class PublicationRepoBase {
  Future<ApiResult<void>> createPublication(
      String title,
      String description,
      List<String> keywords,
      String language,
      String visibility,
      String categoryId);

  Future<ApiResult<List<Publication>>> getPublications();
  Future<ApiResult<List<Publication>>> getPublicationsByCategory(
      String categoryId);
  //*-----------------------------
  Future<ApiResult<List<Publication>>> getUserPublications();
  Future<ApiResult<Publication>> getUserPublicationById(
      String userPublicationId);
  Future<ApiResult<Publication>> getPublicationById(String publicationId);
  Future<ApiResult<void>> changePublicationStatus(
      String publicationId, String status);
  Future<ApiResult<Publication>> changePublicationData(
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
  Future<ApiResult<void>> createPublication(
      String title,
      String description,
      List<String> keywords,
      String language,
      String visibility,
      String categoryId) async {
    try {
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
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<List<Publication>>> getPublications() async {
    try {
      final List<dynamic> publications = await dio.get(EndPoints.publications);
      final List<Publication> publicationsList = publications
          .map((publication) => Publication.fromJson(publication))
          .toList();
      return ApiResult.success(publicationsList);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<List<Publication>>> getPublicationsByCategory(
      String categoryId) async {
    try {
      final List<dynamic> publications =
          await dio.get('${EndPoints.publicationsByCategory}$categoryId');
      return ApiResult.success(publications
          .map((pub) => Publication.fromCategory(pub as Map<String, dynamic>))
          .toList());
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<Publication>> getPublicationById(
      String publicationId) async {
    try {
      final Map<String, dynamic> response =
          await dio.get('${EndPoints.publicationById}$publicationId');
      final publication = Publication.fromJsonById(response);
      return ApiResult.success(publication);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<Publication>> getUserPublicationById(
      String userPublicationId) async {
    try {
      final Map<String, dynamic> response =
          await dio.get('${EndPoints.userPublicationById}$userPublicationId');
      final userPublication = Publication.fromJsonById(response);
      return ApiResult.success(userPublication);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<List<Publication>>> getUserPublications() async {
    try {
      final List<dynamic> userPublications =
          await dio.get(EndPoints.userPublications);
      return ApiResult.success(
          userPublications.map((pub) => Publication.fromJson(pub)).toList());
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<void>> changePublicationStatus(
      String publicationId, String status) async {
    try {
      await dio.patch('${EndPoints.userPublicationStatus}$publicationId',
          queryParameters: {ApiKeys.id: publicationId},
          data: {ApiKeys.type: status});
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<Publication>> changePublicationData(
      String publicationId,
      String? title,
      String? description,
      String? language,
      String? visibility,
      String? categoryId,
      List<String?>? keywords) async {
    try {
      final Response response = await dio
          .put('${EndPoints.userPublicationById}$publicationId', data: {
        ApiKeys.title: title,
        ApiKeys.abstract: description,
        ApiKeys.keywords: keywords,
        ApiKeys.language: language,
        ApiKeys.visibility: visibility,
        ApiKeys.categoryId: categoryId,
      });
      final editedPublication = Publication.fromJsonById(response.data);
      return ApiResult.success(editedPublication);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
