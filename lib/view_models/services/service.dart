import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:main_loan_app/res/routes/routes_name.dart';
import 'package:main_loan_app/view_models/shared_p/shared_preference.dart';


class SplashServices {
  void isLogin() {
    final UserPreference userPreference = UserPreference();
    userPreference.getUserToken().then((token) {
      if (kDebugMode) {
        print(token);
      }
      if (token == null) {
        Timer(const Duration(seconds: 3), () => Get.toNamed(RoutesName.loginScrren));
      } else {
        Timer(const Duration(seconds: 3), () => Get.toNamed(RoutesName.homePage));
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
