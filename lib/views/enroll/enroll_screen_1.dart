import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main_loan_app/res/components/loan_text_field.dart';
import 'package:main_loan_app/res/components/my_button.dart';
import 'package:main_loan_app/res/routes/routes_name.dart';
import 'package:main_loan_app/view_models/controllers/enroll_controller/enroll_controller.dart';
import 'package:main_loan_app/view_models/controllers/page_controller/page_controller.dart';

class EnterNames extends StatefulWidget {
  const EnterNames({super.key});

  @override
  State<EnterNames> createState() => _EnterNamesState();
}

class _EnterNamesState extends State<EnterNames> {
  final enrollController = Get.find<EnrollController>();
  final pageController = Get.put(PageControllers());
  late String email;
  late CollectionReference collection;
  DocumentReference? documentReference;

  final usernameController = TextEditingController();
  final middleNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final dateOfBirthController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final enroll = enrollController.enroll.value;
    if (enroll != null) {
      usernameController.text = enroll.user.fname;
      lastNameController.text = enroll.user.lname;
      middleNameController.text = enroll.user.middleName ?? "";
      dateOfBirthController.text = enroll.user.dob;
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    middleNameController.dispose();
    lastNameController.dispose();
    dateOfBirthController.dispose();
    super.dispose();
  }

  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<FormState>();
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
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Obx(
                              () => Text(
                                "${pageController.pageCount.value.toString()}/4",
                                style: const TextStyle(fontSize: 25),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          LoanTextField(
                              onPressed: () {
                                enrollController.fetchData();
                              },
                              minLength: 2,
                              maxLength: 15,
                              check: (value) {
                                enrollController.setFName(value!);
                              },
                              textType: TextInputType.name,
                              msg: "Enter your First name",
                              labelText: "first_name".tr,
                              myController: usernameController,
                              hintText: "first_name".tr,
                              validate: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter your first name";
                                } else if (value.length <= 2 ||
                                    value.length >= 15) {
                                  return "Please Enter minimum character 2 and Maximum character 15";
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 50.0,
                          ),
                          LoanTextField(
                            check: (value) {
                              enrollController.setMiddle(value!);
                            },
                            minLength: 2,
                            maxLength: 15,
                            textType: TextInputType.name,
                            labelText: "middle_name".tr,
                            myController: middleNameController,
                            hintText: "middle_name".tr,
                          ),
                          const SizedBox(
                            height: 50.0,
                          ),
                          LoanTextField(
                              check: (value) {
                                enrollController.setLName(value!);
                              },
                              minLength: 2,
                              maxLength: 15,
                              textType: TextInputType.name,
                              msg: "Enter your last name",
                              labelText: "last_name".tr,
                              myController: lastNameController,
                              hintText: "last_name".tr,
                              validate: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter your first name";
                                } else if (value.length <= 2 ||
                                    value.length >= 15) {
                                  return "Please Enter minimum character 2 and Maximum character 15";
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 50.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: LoanTextField(
                                    check: (value) {},
                                    myController: dateOfBirthController,
                                    hintText: "dob".tr,
                                    textType: TextInputType.datetime),
                              ),
                              Card(
                                elevation: 3,
                                child: IconButton(
                                    onPressed: () {
                                      _selectDate(context, enrollController);
                                    },
                                    icon: const Icon(
                                      Icons.calendar_month,
                                      size: 40,
                                    )),
                              )
                            ],
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
                      if (kDebugMode) {
                        print("pressed");
                      }

                      pageController.setPageNo(2);
                      await Get.toNamed(RoutesName.enrollScrren2);
                      pageController.setPageNo(1);
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
      firstDate: DateTime(1978),
      lastDate: DateTime(2101),
      initialEntryMode: DatePickerEntryMode.calendar,
    );

    if (picked != null) {
      controller.selectedDate.value = picked;
      controller.selectDate(picked);

      final formattedDate = DateFormat('MM/dd/yyyy').format(picked);
      dateOfBirthController.text = formattedDate;
    }
  }
}
