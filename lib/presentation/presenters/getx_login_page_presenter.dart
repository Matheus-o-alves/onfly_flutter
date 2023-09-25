import 'package:get/get.dart';
import 'package:onfly_flutter/data/usecases/remote_login.dart';

import '../../ui/pages/login/login.presenter.dart';

class GetXLoginPresenter extends GetxController implements LoginPagePresenter {
  RemoteAuthRequest remoteAuthReques = RemoteAuthRequest();

  @override
  var error = RxnString();
  final _navigateTo = Rx<String?>(null);

  @override
  Stream<String?> get navigateToStream => _navigateTo.stream;

  @override
  Future<void> navigationHomePage() async {
    _navigateTo.value = '/home-page';
  }

  @override
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await remoteAuthReques.loginWithEmailAndPassword(email, password);
      await navigationHomePage();
    } catch (error) {
      print('Error: $error');
    }
  }
}
