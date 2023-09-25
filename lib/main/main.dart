import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onfly_flutter/utils/app_translations.dart';

import '../data/models/hive_model/expense_model_hive.dart';
import '../utils/injection_config.dart';
import 'factories/login/login_page_factory.dart';
import 'factories/home/home_page_factory.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenseModelHiveAdapter());
  await Hive.openBox<ExpenseModelHive>('expenses');
  configureInjection();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ONFLY',
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('pt', 'BR'),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: makeLoginPage,
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/home-page',
          page: makeHomePage,
          transition: Transition.fadeIn,
        ),
      ],
    );
  }
}
