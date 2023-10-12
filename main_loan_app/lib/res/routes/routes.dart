import 'package:get/get.dart';
import 'package:main_loan_app/res/routes/routes_name.dart';
import 'package:main_loan_app/views/enroll/enroll_screen_1.dart';
import 'package:main_loan_app/views/enroll/enroll_screen_2.dart';
import 'package:main_loan_app/views/enroll/enroll_screen_4.dart';
import 'package:main_loan_app/views/login/login_screeen.dart';

import '../../views/enroll/enroll_screen_3.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(name: RoutesName.loginScrren, page: () => const LoginScreen()),
        GetPage(name: RoutesName.enrollScrren1, page: () => const EnterNames()),
        GetPage(
            name: RoutesName.enrollScrren2, page: () => const EnrollScreen2()),
        GetPage(
            name: RoutesName.enrollScrren3, page: () => const EnrollScreen3()),
        GetPage(
            name: RoutesName.enrollScrren4, page: () => const EnrollScreen4()),
      ];
}
