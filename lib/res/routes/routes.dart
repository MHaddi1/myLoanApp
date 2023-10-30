import 'package:get/get.dart';
import 'package:main_loan_app/res/routes/routes_name.dart';
import 'package:main_loan_app/views/enroll/enroll_screen_1.dart';
import 'package:main_loan_app/views/enroll/enroll_screen_2.dart';
import 'package:main_loan_app/views/enroll/enroll_screen_4.dart';
import 'package:main_loan_app/views/enroll/enroll_security.dart';
import 'package:main_loan_app/views/home/home_page.dart';
import 'package:main_loan_app/views/loan_applied/loan_applied.dart';
import 'package:main_loan_app/views/login/login_screeen.dart';
import 'package:main_loan_app/views/splash_screen.dart';

import '../../views/enroll/enroll_screen_3.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
          name: RoutesName.splashScreen,
          page: () => const SplashScreen(),
          transition: Transition.leftToRight,
        ),
        GetPage(
          name: RoutesName.loginScrren,
          page: () => const LoginScreen(),
          transition: Transition.leftToRight,
        ),
        GetPage(
          name: RoutesName.enrollScrren1,
          page: () => const EnterNames(),
          transition: Transition.leftToRight,
        ),
        GetPage(
          name: RoutesName.enrollScrren2,
          page: () => const EnrollScreen2(),
          transition: Transition.leftToRight,
        ),
        GetPage(
          name: RoutesName.enrollScrren3,
          page: () => const EnrollScreen3(),
          transition: Transition.leftToRight,
        ),
        GetPage(
          name: RoutesName.enrollScrren4,
          page: () => const EnrollScreen4(),
          transition: Transition.leftToRight,
        ),
        GetPage(
          name: RoutesName.enrollScrren5,
          page: () => const EnrollSecurity(),
        ),
        GetPage(
          name: RoutesName.homePage,
          page: () => const HomePage(),
          transition: Transition.leftToRight,
        ),
        GetPage(
          name: RoutesName.loanApplied,
          page: () => const LoanApplied(),
          transition: Transition.leftToRight,
        ),
      ];
}
