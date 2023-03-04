import 'package:flutter/material.dart';

class LocalizationProvider extends ChangeNotifier {
  Locale _locale = Locale('en');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  // Map<String, String> get translations =>
  //     EasyLocalization.of(RoutesUtils.cNavigatorState.currentState!.context)!
  //         .translations;
}
