import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_project/configs/helpers/theme_helper.dart';
import 'package:test_project/configs/utils/routes_utils.dart';
import 'package:test_project/servicesimplement/services_implement.dart';
import 'package:test_project/src/modules/authenticationmodule/viewmodel/authentication_viewmodel.dart';
import 'package:test_project/src/modules/myProfileModule/viewmodel/profile_viewmodel.dart';

import 'configs/helpers/localization_helper.dart';

class App extends StatelessWidget {
  const App({super.key, required this.servicesImplementation});

  final ServicesImplementation servicesImplementation;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AuthenticationViewModel(
                servicesImplementation, servicesImplementation),
          ),
          ChangeNotifierProvider(
            create: (context) => ProfileViewModel(
                servicesImplementation, servicesImplementation),
          ),
          ChangeNotifierProvider(create: (_) => LocalizationProvider()),
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
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
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'TestApp',
        debugShowCheckedModeBanner: false,

        // darkTheme: AppTheme.themeDarkData,
        theme: Provider.of<ThemeProvider>(context).currentTheme,
        //theme: AppTheme.themeData,
        routerConfig: routerConfigs,
      ),
    );
  }
}
