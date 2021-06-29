import 'package:kate_botique_app/models/payment.dart';
import 'package:kate_botique_app/routes/respository.dart';

class PaymentService {
  Repository _repository;

  PaymentService(){
    _repository = Repository();
  }

  makePayment(Payment payment) async {
    return await _repository.httpPost('make-payment', payment.toJson());
  }
}
