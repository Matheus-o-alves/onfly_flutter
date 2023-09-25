import 'package:flutter_test/flutter_test.dart';

import 'package:onfly_flutter/presentation/presenters/getx_login_page_presenter.dart';

void main() {
  group('GetXLoginPresenter Tests', () {
    test('navigationHomePage sets navigateTo value', () async {
      final presenter = GetXLoginPresenter();

      expect(presenter.navigateToStream, emits('/home-page'));

      await presenter.navigationHomePage();
    });
  });
}
