import 'package:collabry/core/api/dio_consumer.dart';
import 'package:collabry/core/api/end_points.dart';
import 'package:collabry/features/home_page/model/category_model.dart';

abstract class PublicationRepoBase {
  Future<List<CategoryModel>> getCategories();
}

class PublicationRepo implements PublicationRepoBase {
  final DioConsumer dio;
  PublicationRepo({required this.dio});

  @override
  Future<List<CategoryModel>> getCategories() async {
    final List<dynamic> categories = await dio.get(EndPoints.categories);
    final List<CategoryModel> categoriesList =
        categories.map((category) => CategoryModel.fromJson(category)).toList();
    return categoriesList;
  }
}
