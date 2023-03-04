import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:test_project/servicesimplement/services_implement.dart';

import 'app.dart';
import 'configs/helpers/http_api_helper.dart';

Future<void> main() async {
  //

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await Hive.initFlutter();

  HttpApiHelper httpApiHelper = HttpApiHelper(Dio());

  ServicesImplementation servicesImplementation =
      ServicesImplementation(httpApiHelper);

  runApp(App(
    servicesImplementation: servicesImplementation,
  ));
}
