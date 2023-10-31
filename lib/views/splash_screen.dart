import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main_loan_app/view_models/controllers/enroll_controller/enroll_controller.dart';
import 'package:main_loan_app/view_models/services/service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashService = SplashServices();
  final enrollController = Get.put(EnrollController(), permanent: true);

  @override
  void initState() {
    super.initState();
    splashService.isLogin();
    //enrollController.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[400],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            "https://images.sftcdn.net/images/t_app-icon-m/p/56e4b038-3f90-406f-a6f7-57a5a418f361/2594640530/smart-loan-payday-loans-app-logo",
            height: 100,
          ),
          const SizedBox(
            height: 12.0,
          ),
          const CircularProgressIndicator(
            color: Colors.white,
          ),
          const Center(
            child: Column(
              children: [
                Text(
                  "Welcome Back...",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
