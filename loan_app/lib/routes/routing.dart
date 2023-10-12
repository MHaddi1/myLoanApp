import 'package:get/get.dart';
import 'package:loan_app/views/document_add.dart';
import 'package:loan_app/views/loan_application.dart';
import 'package:loan_app/views/loan_application_2.dart';
import 'package:loan_app/views/login_screen.dart';

class Routes {
  static const loginScreen = '/';
  static const loanScreen = '/loan_screen_1';
  static const detailScreen = "/detail_screen";
  static const doucment = "/upload_doucment";
}

class AppPages {
  static final pages = [
    GetPage(name: Routes.loginScreen, page: () => const MyLoginScreen()),
    GetPage(name: Routes.loanScreen, page: () =>   LoanScreen()),
    GetPage(name: Routes.detailScreen, page: () => const WorkDetail()),
    GetPage(name: Routes.doucment, page: () => const AddDoument()),
  ];
}
