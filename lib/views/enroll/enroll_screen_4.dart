import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:dob_input_field/dob_input_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main_loan_app/models/enroll_model.dart';
import 'package:main_loan_app/res/colors/color.dart';
import 'package:main_loan_app/res/components/date_entry.dart';
import 'package:main_loan_app/res/components/loan_text_field.dart';
import 'package:main_loan_app/res/components/my_button.dart';
import 'package:main_loan_app/res/routes/routes_name.dart';
import 'package:main_loan_app/view_models/controllers/enroll_controller/enroll_controller.dart';
// import 'package:main_loan_app/res/routes/routes_name.dart';
import 'package:main_loan_app/view_models/controllers/page_controller/page_controller.dart';

class EnrollScreen4 extends StatefulWidget {
  const EnrollScreen4({super.key});

  @override
  State<EnrollScreen4> createState() => _EnrollScreen4State();
}

class _EnrollScreen4State extends State<EnrollScreen4> {
  final enrollController = Get.find<EnrollController>();
  final pageController = Get.find<PageControllers>();
  final key = GlobalKey<FormState>();
  final dateOfBirthController = TextEditingController();
  final idNubmerController = TextEditingController();
    
  @override
  void initState() {
    super.initState();
     final enroll = enrollController.enroll.value;
     if(enroll!=null){
      idNubmerController.text = enroll.moreDetails.numbersDetail;
     }
    
  }
  @override
  void dispose() {
    idNubmerController.dispose();
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          Obx(
                            () => DropdownButtonFormField<String>(
                              validator: (value){
                                if(value!.isEmpty){
                                  return "required *";
                                }
                                return null;
                              },
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
                            check: (value){
                              enrollController.setDetailNumber(value!);
                            },
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
                            myController: idNubmerController,
                            hintText: "id_number".tr,
                          ),
                          const SizedBox(
                            height: 50.0,
                          ),
                          CSCPicker(
                            //currentState: 'Punjab',
                            stateDropdownLabel: "Issued State",
                            showCities: false,
                            showStates: true,
                            disableCountry: true,
                            // countryFilter: Get.arguments,
                            // currentCountry: Get.arguments[0],
                            // countryFilter: Get.arguments,

                            onCountryChanged: (value) async {
                              // if (kDebugMode) {
                              //   print(Get.arguments);
                              // }
                              await enrollController.updateCountry(value);
                            },
                            onStateChanged: (value) async {
                              await enrollController
                                  .updateState(value ?? "Not State");
                              if (kDebugMode) {
                                print(value);
                              }
                            },
                            onCityChanged: (value) async {
                              await enrollController
                                  .updateCity(value ?? "Not City");
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
                            controller: dateOfBirthController,
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
                  onTap: () async{
                    //Enroll myEnroll;
                    if (key.currentState!.validate()) {
                      key.currentState!.save();

                      //Get.find<EnrollController>().toggleLoading();
                      FirebaseAuth firebaseAuth;
                      firebaseAuth = FirebaseAuth.instance;
                      final user = firebaseAuth.currentUser;

                      if(user != null){
                         final idTokenResult = await user.getIdToken();
                        if(idTokenResult!=null){

                          enrollController.onAddEnrollData();
                          enrollController.updateLoanStatus(user.uid, 0);
                          Get.toNamed(RoutesName.homePage);
                          
                        }
                      }else{
                      Get.toNamed(RoutesName.enrollScrren5);
                      if (kDebugMode) {
                        print("pressed");
                      }
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

  Future<void> selectDate(
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
