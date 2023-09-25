import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:onfly_flutter/data/usecases/remote_login.dart';
import 'package:onfly_flutter/presentation/presenters/getx_login_page_presenter.dart';

void main() {
  group('GetXLoginPresenter', () {
    test('loginWithEmailAndPassword should navigate to home page on success',
        () async {
      final presenter = GetXLoginPresenter();
      final mockEmail = 'test@example.com';
      final mockPassword = 'password';

      final mockRemoteAuthRequest = MockRemoteAuthRequest();

      when(mockRemoteAuthRequest.loginWithEmailAndPassword(
              'mockEmail', 'mockPassword'))
          .thenAnswer((_) => Future.value());

      presenter.remoteAuthReques = mockRemoteAuthRequest;

      await presenter.loginWithEmailAndPassword(mockEmail, mockPassword);

      expect(presenter.navigateToStream, emits('/home-page'));
    });

    test('loginWithEmailAndPassword should set error on failure', () async {
      final presenter = GetXLoginPresenter();
      final mockEmail = 'test@example.com';
      final mockPassword = 'password';

      // Substitua pelo seu mock ou implementação do RemoteAuthRequest.
      final mockRemoteAuthRequest = MockRemoteAuthRequest();

      // Substitua pelo seu mock ou implementação do método loginWithEmailAndPassword.
      when(mockRemoteAuthRequest.loginWithEmailAndPassword(
              mockEmail, mockPassword))
          .thenThrow('Login failed'); // Simule um erro de login.

      presenter.remoteAuthReques = mockRemoteAuthRequest;

      await presenter.loginWithEmailAndPassword(mockEmail, mockPassword);

      expect(presenter.error.value, 'Login failed');
    });

    test('navigationHomePage should set navigateTo value', () async {
      final presenter = GetXLoginPresenter();

      await presenter.navigationHomePage();

      expect(presenter.navigateToStream, emits('/home-page'));
    });
  });
}

// MockRemoteAuthRequest é uma classe fictícia que implementa RemoteAuthRequest para fins de teste.
class MockRemoteAuthRequest extends Mock implements RemoteAuthRequest {}
