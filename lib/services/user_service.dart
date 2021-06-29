import 'package:kate_botique_app/models/user.dart';
import 'package:kate_botique_app/routes/respository.dart';

class UserService {
  Repository _repository;

  UserService() {
    _repository = Repository();
  }

  createUser(User user) async {
    return await _repository.httpPost('register', user.toJson());
  }

  login(User user) async {
    return await _repository.httpPost('login', user.toJson());
  }
}
