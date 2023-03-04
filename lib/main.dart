import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:test_project/servicesimplement/services_implement.dart';
import 'package:test_project/translations/codegen_loader.g.dart';

import 'app.dart';
import 'configs/helpers/http_api_helper.dart';

Future<void> main() async {
  //

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp();

  await Hive.initFlutter();

  HttpApiHelper httpApiHelper = HttpApiHelper(Dio());

  ServicesImplementation servicesImplementation =
      ServicesImplementation(httpApiHelper);

  runApp(EasyLocalization(
    assetLoader: CodegenLoader(),
    supportedLocales: const [
      Locale(
        'en',
      ),
      Locale(
        'fr',
      ),
    ],
    fallbackLocale: const Locale('en'),
    path: 'assets/translations',
    // <-- change the path of the translation files
    child: App(
      servicesImplementation: servicesImplementation,
    ),
  ));
}
