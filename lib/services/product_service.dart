import 'package:kate_botique_app/routes/respository.dart';

class ProductService {
  Repository _repository;
  ProductService() {
    _repository = Repository();
  }

  getHotProducts() async {
    return await _repository.httpGet('get-all-hot-products');
  }

  getProductsByCategoryId(categoryId) async {
    return await _repository.httpGetById(
      "products-by-cate",
      categoryId.toString(),
    );
  }
}
