import 'package:collabry/core/api/dio_consumer.dart';
import 'package:collabry/core/api/end_points.dart';
import 'package:collabry/core/api/networking/api_error_handler.dart';
import 'package:collabry/core/api/networking/api_result.dart';
import 'package:collabry/features/home_page/data/models/category_model.dart';

abstract class CategoryRepositoryBase {
  Future<ApiResult<List<CategoryModel>>> getCategories();
}

class CategoryRepo implements CategoryRepositoryBase {
  final DioConsumer dio;
  CategoryRepo({required this.dio});

  @override
  Future<ApiResult<List<CategoryModel>>> getCategories() async {
    try {
      final List<dynamic> categories = await dio.get(EndPoints.categories);
      final List<CategoryModel> categoriesList = categories
          .map((category) => CategoryModel.fromJson(category))
          .toList();
      return ApiResult.success(categoriesList);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
