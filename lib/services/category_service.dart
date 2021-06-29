import 'package:kate_botique_app/routes/respository.dart';

class CategoryService {
  Repository _repository;
  CategoryService() {
    _repository = Repository();
  }

  getCategories() async {
    return await _repository.httpGet('categories');
  }
  
}
