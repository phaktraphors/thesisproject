import 'package:kate_botique_app/routes/respository.dart';

class SliderService {
  Repository _repository;
  SliderService() {
    _repository = Repository();
  }

  getSliders() async {
    return await _repository.httpGet('sliders');
  }
  
}
