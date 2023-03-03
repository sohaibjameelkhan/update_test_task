import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_project/src/configs/utils/routes_utils.dart';
import 'package:test_project/src/configs/utils/theme.dart';
import 'package:test_project/src/modules/authenticationModule/providers/authentication_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AuthenticationProvider(),
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(428, 926),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) => const AppMaterial(),
        ));
  }
}

class AppMaterial extends StatelessWidget {
  const AppMaterial({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
      child: MaterialApp.router(
        title: 'TestApp',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.themeData,
        routerConfig: routerConfigs,
      ),
    );
  }
}
