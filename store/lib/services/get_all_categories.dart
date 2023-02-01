import 'package:store/helper/api.dart';

class GetCategoriesService {
  Future<List<dynamic>> getAllCategories() async {
    List<dynamic> data =
        await Api().get(uri: 'https://fakestoreapi.com/products/categories');
    return data;
  }
}
