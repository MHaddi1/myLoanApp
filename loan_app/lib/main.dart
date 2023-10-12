import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_app/routes/routing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.loginScreen,
      getPages: AppPages.pages,
    );
  }
}
