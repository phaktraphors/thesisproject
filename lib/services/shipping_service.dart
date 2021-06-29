import 'package:kate_botique_app/models/shipping.dart';
import 'package:kate_botique_app/routes/respository.dart';

class ShippingService {
  Repository _repository;

  ShippingService(){
    _repository = Repository();
  }

  addShipping(Shipping shipping) async {
    return await _repository.httpPost('shipping', shipping.toJson(),);
  }
}