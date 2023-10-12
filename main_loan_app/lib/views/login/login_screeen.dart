import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main_loan_app/res/colors/color.dart';
import 'package:main_loan_app/res/components/loan_text_field.dart';
import 'package:main_loan_app/res/components/my_button.dart';
import 'package:main_loan_app/res/routes/routes_name.dart';
import 'package:main_loan_app/view_models/controllers/login_controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginController = Get.put(LoginController());
  final _key = GlobalKey<FormState>();
  List<String> mylist = ['haddi', 'hassam', 'ammar'];

  @override
  void initState() {
    super.initState();
    _loadSavedUsername();
  }

  void _loadSavedUsername() async {
    // final savedUsername = await loginController.getSavedUsername();
    // if (savedUsername != null) {
    // loginController.usernameController.text = savedUsername;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: Get.width,
            height: Get.height,
            child: Form(
              key: _key,
              child: Column(
                children: [
                  const Text(
                    "Faundz",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 32,
                        color: AppColor.mainColor),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    "We’ve missed you! Sign in to\n continue",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                        color: AppColor.textGrey),
                    textAlign: TextAlign.center,
                    //textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15.0),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 15.0),
                      child: Container(
                        // height: MediaQuery.of(context).size.height * 0.65,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          child: Column(
                            children: [
                              LoanTextField(
                                textType: TextInputType.name,
                                msg: "Please Enter username",
                                minLength: 5,
                                maxLength: 15,
                                onPressed: () {},
                                validate: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please Enter your first name";
                                  } else if (value.length <= 2 &&
                                      value.length >= 15) {
                                    return "Please Enter minimum character 2 and Maximum character 15";
                                  }
                                  return null;
                                },
                                myController:
                                    loginController.usernameController,
                                hintText: "email_hint".tr,
                                obscureText: false,
                              ),
                              const SizedBox(
                                height: 12.0,
                              ),
                              Obx(
                                () => LoanTextField(
                                  textType: TextInputType.visiblePassword,
                                  msg: "Please enter Password",
                                  maxLength: 15,
                                  minLength: 8,
                                  validate: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please Enter your first name";
                                    } else if (value.length <= 2 &&
                                        value.length >= 15) {
                                      return "Please Enter minimum character 2 and Maximum character 15";
                                    }
                                    return null;
                                  },
                                  onSuffixIconTap: () =>
                                      loginController.showPassword(),
                                  myController:
                                      loginController.passwordController,
                                  hintText: "passwords".tr,
                                  obscureText:
                                      loginController.isShowPassword.value,
                                  suffixIconData:
                                      loginController.isShowPassword.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "forget_password".tr,
                                    style: const TextStyle(
                                        color: AppColor.mainColor,
                                        fontSize: 19.0),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              // Align(
                              //     alignment: Alignment.center,
                              //     child: Image.asset("assets/icons/face_r.png")),
                              Row(
                                children: [
                                  Obx(
                                    () => Checkbox(
                                        value:
                                            loginController.saveUsername.value,
                                        onChanged: (val) {
                                          loginController.saveUsername.value =
                                              val!;
                                        }),
                                  ),
                                  Text("save_user".tr),
                                ],
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              MyButton(
                                text: "sign_on".tr,
                                onTap: () async {
                                  if (_key.currentState!.validate()) {
                                    _key.currentState!.save();
                                    if (loginController.saveUsername.value) {
                                      await loginController.saveUsernames(
                                          loginController
                                              .usernameController.value.text);
                                    }

                                    //await loginController.getSavedUsername();

                                    //loginController.loginApi();
                                  }
                                  // Get.toNamed(RoutesName.loginScrren);
                                },
                              ),
                              const SizedBox(
                                height: 50.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "new_user".tr,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.toNamed(RoutesName.enrollScrren1);
                                    },
                                    child: Text(
                                      "enroll".tr,
                                      style: const TextStyle(
                                          color: AppColor.mainColor,
                                          fontSize: 18),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
