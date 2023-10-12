import 'package:csc_picker/csc_picker.dart';
//import 'package:dob_input_field/dob_input_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main_loan_app/res/colors/color.dart';
import 'package:main_loan_app/res/components/date_entry.dart';
import 'package:main_loan_app/res/components/loan_text_field.dart';
import 'package:main_loan_app/res/components/my_button.dart';
import 'package:main_loan_app/view_models/controllers/page_controller/page_controller.dart';

import '../../view_models/controllers/enroll_controller/enroll_controller.dart';

class EnrollScreen4 extends StatefulWidget {
  const EnrollScreen4({super.key});

  @override
  State<EnrollScreen4> createState() => _EnrollScreen4State();
}

class _EnrollScreen4State extends State<EnrollScreen4> {
  final enrollController = Get.put(EnrollController());
  final pageController = Get.put(PageControllers());
  final key = GlobalKey<FormState>();

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
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15, horizontal: 12.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: key,
                      child: Column(
                        children: [
                          Obx(
                            () => DropdownButtonFormField<String>(
                              hint: const Text("Occupation"),
                              value: enrollController.selectedItem4.value,
                              icon: null,
                              onChanged: (String? newValue) {
                                enrollController.setSelectedItem(newValue!);
                              },
                              dropdownColor: AppColor.feildColor,
                              items: <String>[
                                'Driver Lic/State ID',
                                'Consular ID',
                                'Other',
                              ].map((String val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(
                            height: 50.0,
                          ),
                          LoanTextField(
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter your ID Number ";
                              } else if (value.length <= 2 &&
                                  value.length >= 11) {
                                return "Please Enter minimum character 2 and Maximum character 15";
                              }
                              return null;
                            },
                            msg: "Please Enter ID Number",
                            textType: TextInputType.name,
                            labelText: "id_number".tr,
                            myController: enrollController.idNubmerController,
                            hintText: "id_number".tr,
                          ),
                          const SizedBox(
                            height: 50.0,
                          ),
                          CSCPicker(
                            stateDropdownLabel: "Issued State",
                            showCities: false,
                            showStates: true,
                            disableCountry: true,
                            currentCountry: Get.arguments[0],
                            // countryFilter: Get.arguments,

                            // onCountryChanged: (value) {
                            //   if (kDebugMode) {
                            //     print(Get.arguments);
                            //   }
                            //   enrollController.updateCountry(value);
                            // },
                            onStateChanged: (value) {
                              enrollController.updateState(value ?? "");
                            },
                          ),
                          const SizedBox(
                            height: 50.0,
                          ),
                          // Row(
                          //   children: [
                          //     const Text(
                          //       "Issed Date:",
                          //       style: TextStyle(fontSize: 18),
                          //     ),
                          //     SizedBox(
                          //       width: Get.width * 0.10,
                          //     ),
                          //     Obx(() => Text(
                          //           "${enrollController.selectedDate.value.toLocal()}"
                          //               .split(' ')[0],
                          //           style: const TextStyle(fontSize: 18),
                          //         )),
                          //     IconButton(
                          //         onPressed: () {
                          //           _selectDate(context, enrollController);
                          //         },
                          //         icon: const Icon(Icons.calendar_month))
                          //   ],
                          // ),
                          DOBInputField(
                            controller: enrollController.dateOfBirthController,
                            fieldLabelText: 'Date of Birth',
                            onChanged: (selectedDate) {
                              // Handle the selected date
                              print('Selected Date: $selectedDate');
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 70.0,
                ),
                MyButton(
                  text: "continue".tr,
                  onTap: () {
                    if (key.currentState!.validate()) {
                      key.currentState!.save();
                      if (kDebugMode) {
                        print("pressed");
                      }
                      // Get.toNamed(RoutesName.enrollScrren2);
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

  Future<void> _selectDate(
      BuildContext context, EnrollController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != controller.selectedDate.value) {
      controller.selectDate(picked);
    }
  }
}
