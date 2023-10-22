import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main_loan_app/res/components/loan_text_field.dart';
import 'package:main_loan_app/res/components/my_button.dart';
import 'package:main_loan_app/res/routes/routes_name.dart';
import 'package:main_loan_app/view_models/controllers/enroll_controller/enroll_controller.dart';

class EnrollSecurity extends StatefulWidget {
  const EnrollSecurity({super.key});

  @override
  State<EnrollSecurity> createState() => _EnrollSecurityState();
}

class _EnrollSecurityState extends State<EnrollSecurity> {
  final enrollController = Get.put(EnrollController());
  final key = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
        child: Column(
          children: [
            Form(
              key: key,
              child: Column(
                children: [
                  LoanTextField(
                      obscureText: true,
                      check: (p0) {
                        enrollController.myPassword(p0!);
                      },
                      myController: passwordController,
                      hintText: "password",
                      textType: TextInputType.visiblePassword),
                  const SizedBox(
                    height: 12.0,
                  ),
                  LoanTextField(
                      obscureText: true,
                      check: (p0) {
                        enrollController.cMyPassword(p0!);
                      },
                      myController: confirmPasswordController,
                      hintText: "confirm Password",
                      textType: TextInputType.visiblePassword),
                  Obx(() => Text(
                        "${enrollController.passwordError.value}",
                        style: TextStyle(
                            color: enrollController.getEmailTextColor()),
                      )),
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
            MyButton(
              text: "Confirm",
              onTap: () {
                Get.find<EnrollController>().toggleLoading();
                enrollController.onAddEnrollData();
                Get.toNamed(RoutesName.homePage);
              },
            )
          ],
        ),
      ),
    );
  }
}
