import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'pt_BR': {
          'enter_your_email': 'Digite seu e-mail',
          'password': 'Senha',
          'enter_your_password': 'Digite sua senha',
          'login': 'Entrar',
          'cancel': 'Cancelar',
        },
        'en_US': {
          'enter_your_email': 'Enter your email',
          'password': 'Password',
          'enter_your_password': 'Enter your password',
          'login': 'Login',
          'cancel': 'Cancel',
        },
        'es_AR': {
          'enter_your_email': 'Ingrese su correo electrónico',
          'password': 'Contraseña',
          'enter_your_password': 'Ingrese su contraseña',
          'login': 'Iniciar sesión',
          'cancel': 'Cancelar',
        },
      };
}
