import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main_loan_app/res/colors/color.dart';
import 'package:main_loan_app/res/components/loan_text_field.dart';
import 'package:main_loan_app/res/components/my_button.dart';
import 'package:main_loan_app/res/routes/routes_name.dart';

import '../../view_models/controllers/enroll_controller/enroll_controller.dart';
import '../../view_models/controllers/page_controller/page_controller.dart';

class EnrollScreen3 extends StatefulWidget {
  const EnrollScreen3({super.key});

  @override
  State<EnrollScreen3> createState() => _EnrollScreen3State();
}

class _EnrollScreen3State extends State<EnrollScreen3> {
  final key = GlobalKey<FormState>();
  final enrollController = Get.find<EnrollController>();
  final pageController = Get.find<PageControllers>();
  final ssnController = TextEditingController();
  final itinController = TextEditingController();
  final erpirationController = TextEditingController();

  @override
  void initState() {
    
    super.initState();
    final enroll = enrollController.enroll.value;
    ssnController.text = enroll!.enrollLiving.ssn??"";
    itinController.text = enroll.enrollLiving.itin??"";
    //enrollController.updateCountry(enroll.enrollLiving.country);

  }

  @override
  void dispose() {
    itinController.dispose();
    erpirationController.dispose();
    ssnController.dispose();
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
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15, horizontal: 12.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: key,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          CSCPicker(
                            onCountryChanged: (value) {
                              enrollController.updateCountry(value);
                              if (kDebugMode) {
                                print(value);
                              }
                            },
                            onStateChanged: (value) {
                              enrollController.updateState(value ?? "");
                            },
                            onCityChanged: (value) {
                              if (kDebugMode) {
                                print(value);
                              }
                              enrollController.updateCity(value ?? "");
                            },
                            showCities: true,
                            showStates: true,
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          Obx(
                            () => Row(
                              children: [
                                Radio(
                                  value: true,
                                  groupValue: enrollController
                                      .isFirstRadioSelected.value,
                                  onChanged: (value) {
                                    enrollController.toggleRadio(value ?? true);
                                  },
                                ),
                                Text('ssn'.tr),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          Obx(
                            () => Row(
                              children: [
                                Radio(
                                  value: false,
                                  groupValue: enrollController
                                      .isFirstRadioSelected.value,
                                  onChanged: (value) {
                                    enrollController.toggleRadio(value ?? true);
                                  },
                                ),
                                Text(
                                  'itin'.tr,
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          Obx(
                            () => LoanTextField(
                              check: (value){
                                enrollController.setPersonalNumber(value!);
                              },
                                textType: TextInputType.text,
                                msg: enrollController.isFirstRadioSelected.value
                                    ? "Please enter Socail Security Number"
                                    : "Please enter ITIN",
                                labelText:
                                    enrollController.isFirstRadioSelected.value
                                        ? 'ssn'.tr
                                        : 'itin'.tr,
                                myController:
                                    enrollController.isFirstRadioSelected.value
                                        ? ssnController
                                        : itinController,
                                hintText:
                                    enrollController.isFirstRadioSelected.value
                                        ? 'ssn'.tr
                                        : 'itin'.tr,
                                validate: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "required *";
                                  } else if (value.length < 15 ||
                                      value.length > 17) {
                                    return "Please Enter minimum character 15\n and Maximum character 17";
                                  }
                                  return null;
                                }),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          Obx(
                            () => DropdownButtonFormField<String>(
                              hint: const Text("Occupation"),
                              value: enrollController.selectedItem2.value,
                              icon: null,
                              onChanged: (String? newValue) {
                                enrollController.setSelectedItem(newValue!);
                              },
                              dropdownColor: AppColor.feildColor,
                              items: <String>[
                                'Execution, Profesional, semi Pro',
                                'Manager, Owner, Office',
                                'Prod Sales, Trades, Services Labor',
                                'Military'
                              ].map((String val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          Obx(
                            () => DropdownButtonFormField<String>(
                              validator: (value){
                                if(value!.isEmpty){
                                  return "Not Empty field";
                                }
                                return null;
                              },
                              hint: const Text("Citizen Ship"),
                              value: enrollController.selectedItem3.value,
                              icon: null,
                              onChanged: (String? newValue) {
                                enrollController.setSelectedItem(newValue!);
                              },
                              dropdownColor: AppColor.feildColor,
                              items: <String>[
                                'Resident-Alien',
                                'Non-Resident-Alien'
                              ].map((String val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val),
                                );
                              }).toList(),
                            ),
                          ),
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
                  onTap: () async {
                    if (key.currentState!.validate()) {
                      key.currentState!.save();
                      String data = enrollController.dataTake();
                      if (kDebugMode) {
                        print(data);
                      }
                      //Get.find<EnrollController>().toggleLoading();
                      pageController.setPageNo(4);
                      await Get.toNamed(RoutesName.enrollScrren4,
                          arguments: [data]);
                      pageController.setPageNo(3);
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
