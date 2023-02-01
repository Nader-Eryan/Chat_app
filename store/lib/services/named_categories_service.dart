import 'package:store/models/product_model.dart';

import '../helper/api.dart';

class GetCategoryService {
  Future<List<ProductModel>> getCategoryProducts(
      {required String categoryName}) async {
    List<dynamic> data = await Api()
        .get(uri: 'https://fakestoreapi.com/products/category/$categoryName');
    List<ProductModel> productsList = [];
    for (int i = 0; i < data.length; i++) {
      productsList.add(ProductModel.fromJson(data[i]));
    }
    return productsList;
  }
}
