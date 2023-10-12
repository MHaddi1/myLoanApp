import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main_loan_app/res/colors/color.dart';
import 'package:main_loan_app/res/components/my_button.dart';
import 'package:main_loan_app/res/routes/routes_name.dart';
import 'package:main_loan_app/view_models/controllers/enroll_controller/enroll_controller.dart';
import 'package:main_loan_app/view_models/controllers/page_controller/page_controller.dart';
import '../../res/components/loan_text_field.dart';

class EnrollScreen2 extends StatefulWidget {
  const EnrollScreen2({super.key});

  @override
  State<EnrollScreen2> createState() => _EnrollScreen2State();
}

class _EnrollScreen2State extends State<EnrollScreen2> {
  final key = GlobalKey<FormState>();
  final enrollController = Get.put(EnrollController());
  final pageController = Get.put(PageControllers());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(Icons.arrow_back),
      )),
      body: Container(
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Obx(
                    () => Text(
                      "${pageController.pageCount.value}/4",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15, horizontal: 12.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: key,
                      child: Column(
                        children: [
                          LoanTextField(
                              textType: TextInputType.emailAddress,
                              msg: "Please enter your Email",
                              labelText: "email_hint".tr,
                              myController: enrollController.emailController,
                              hintText: "email_hint".tr,
                              validate: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter text";
                                }
                                if (value.isEmail) {
                                  return null;
                                }
                                return "Please enter a valid email address";
                              }),
                          const SizedBox(
                            height: 25.0,
                          ),
                          Obx(
                            () => DropdownButtonFormField<String>(
                              value: enrollController.selectedItem.value,
                              icon: null,
                              onChanged: (String? newValue) {
                                enrollController.setSelectedItem(newValue!);
                              },
                              dropdownColor: AppColor.feildColor,
                              items: <String>['Phone Number', 'Work', 'Home']
                                  .map((String val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          LoanTextField(
                            textType: TextInputType.phone,
                            msg: "Please enter Phone Number",
                            labelText: "phone_number".tr,
                            myController: enrollController.phoneNoController,
                            hintText: "phone_number".tr,
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter a phone number';
                              } else if (!enrollController
                                  .isPhoneNumberValid(value)) {
                                return 'Please Enter a Valid Phone Number';
                              } else if (value.length < 11 ||
                                  value.length > 15) {
                                return 'Phone number should be between 11 and 15 digits';
                              }
                              return null; // Return null if the value is valid
                            },
                          ),
                          const SizedBox(
                            height: 25.0,
                          ),
                          LoanTextField(
                              textType: TextInputType.number,
                              msg: "Please enter Zip Code",
                              labelText: "zip_code".tr,
                              myController: enrollController.zipCodeController,
                              hintText: "zip_code".tr,
                              validate: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter a zip code";
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 25.0,
                          ),
                          LoanTextField(
                              textType: TextInputType.streetAddress,
                              msg: "Please enter Your Address",
                              labelText: "home_address".tr,
                              validate: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter Complete address";
                                }
                                return null;
                              },
                              myController: enrollController.addressController,
                              hintText: "home_address".tr),
                          const SizedBox(
                            height: 25.0,
                          ),
                          LoanTextField(
                              textType: TextInputType.streetAddress,
                              labelText: "home_address_2".tr,
                              myController:
                                  enrollController.optionalAddressController,
                              hintText: "home_address_2".tr)
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                MyButton(
                  text: "continue".tr,
                  onTap: () async {
                    if (key.currentState!.validate()) {
                      key.currentState!.save();
                      pageController.setPageNo(3);
                      await Get.toNamed(RoutesName.enrollScrren3);
                      pageController.setPageNo(2);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
