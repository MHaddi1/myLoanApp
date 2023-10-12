import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main_loan_app/res/routes/routes.dart';
import 'package:main_loan_app/res/routes/routes_name.dart';
import 'res/get_localization/language.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Loan App',
      translations: Language(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: const EnrollScreen4(),
      initialRoute: RoutesName.loginScrren,
      getPages: AppRoutes.appRoutes(),
    );
  }
}
