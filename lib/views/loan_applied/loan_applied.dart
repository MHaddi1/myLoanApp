import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:main_loan_app/res/colors/color.dart';
import 'package:main_loan_app/res/components/loan_text_field.dart';
import 'package:main_loan_app/res/components/my_button.dart';
import 'package:main_loan_app/view_models/controllers/home_controller/home_controller.dart';

class LoanApplied extends StatefulWidget {
  const LoanApplied({super.key});

  @override
  State<LoanApplied> createState() => _LoanAppliedState();
}

class _LoanAppliedState extends State<LoanApplied> {
  final business = TextEditingController();
  final businessAdress = TextEditingController();
  final deadLine = TextEditingController();
  final amount = TextEditingController();
  final reason = TextEditingController();
  final key = GlobalKey<FormState>();
  final homeController = Get.find<HomeController>();
  @override
  void dispose() {
    business.dispose();
    businessAdress.dispose();
    deadLine.dispose();
    amount.dispose();
    business.clear();
    businessAdress.clear();
    deadLine.clear();
    amount.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Form(
                  key: key,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(
                                    0, 1), // changes position of shadow
                              )
                            ]),
                        child: LoanTextField(
                            check: (value) {
                              homeController.businessName(value!);
                            },
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your business name';
                              }
                              return null;
                            },
                            myController: business,
                            hintText: "Enter Your Business Name",
                            textType: TextInputType.text),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(
                                    0, 1), // changes position of shadow
                              )
                            ]),
                        child: LoanTextField(
                            check: (value) {
                              homeController.businessAddress(value!);
                            },
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'please Enter Your  business Address';
                              }
                              return null;
                            },
                            myController: businessAdress,
                            hintText: "Enter Your Business Address",
                            textType: TextInputType.streetAddress),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Obx(
                        () => Container(
                          padding: const EdgeInsets.only(left: 10),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            children: [
                              DropdownButtonFormField<String>(
                                hint: const Text("interest Rate"),
                                value: homeController.selectedItem2.value,
                                icon: null,
                                onChanged: (String? newValue) {
                                  homeController.setSelectedItem2(newValue!);
                                  homeController.myMessage();
                                },
                                dropdownColor: AppColor.feildColor,
                                items: <String>[
                                  '5 Year',
                                  '10 Year',
                                ].map((String val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child: Text(val),
                                  );
                                }).toList(),
                              ),
                              Obx(() => Row(
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        homeController.interest.value,
                                        style:
                                            const TextStyle(color: Colors.red),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(
                                    0, 1), // changes position of shadow
                              )
                            ]),
                        child: LoanTextField(
                            check: (value) {
                              homeController.amount(value!);
                            },
                            maxLength: 4,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'please Enter Your amount';
                              }
                              return null;
                            },
                            myController: amount,
                            hintText: "How much you loan want?",
                            textType: TextInputType.number),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(
                                    0, 1), // changes position of shadow
                              )
                            ]),
                        child: LoanTextField(
                            maxLines: 3,
                            check: (value) {
                              homeController.setReason(value!);
                            },
                            maxLength: 100,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'please Enter Your Reason';
                              }
                              return null;
                            },
                            myController: reason,
                            hintText: "Enter Your Reason for Loan",
                            textType: TextInputType.multiline),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                MyButton(
                  text: "Applied",
                  onTap: () {
                    if (key.currentState!.validate()) {
                      key.currentState!.save();

                      homeController.addLoanAmount();

                      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
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
      BuildContext context, HomeController controller) async {
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
      deadLine.text = formattedDate;
    }
  }
}
