import 'package:get/get.dart';

abstract class LoginPagePresenter {
  var error = RxnString();
  Stream<String?> get navigateToStream;
  Future<void> navigationHomePage();
  Future<void> loginWithEmailAndPassword(String email, String password);
}
