import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main_loan_app/res/colors/color.dart';
import 'package:main_loan_app/res/components/my_button.dart';
import 'package:main_loan_app/view_models/controllers/enroll_controller/enroll_controller.dart';
import 'package:main_loan_app/view_models/controllers/page_controller/page_controller.dart';
import '../../res/components/loan_text_field.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class EnrollScreen2 extends StatefulWidget {
  const EnrollScreen2({super.key});

  @override
  State<EnrollScreen2> createState() => _EnrollScreen2State();
}

class _EnrollScreen2State extends State<EnrollScreen2> {
  final key = GlobalKey<FormState>();
  final enrollController = Get.put(EnrollController());
  final pageController = Get.put(PageControllers());
  final emailController = TextEditingController();
  final phoneNoController = TextEditingController();
  final zipCodeController = TextEditingController();
  final addressController = TextEditingController();
  final optionalAddressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final enroll = enrollController.enroll.value;
    if (enroll != null) {
      emailController.text = enroll.enrollDetails.email;
      phoneNoController.text = enroll.enrollDetails.phone;
      zipCodeController.text = enroll.enrollDetails.zipcode.toString();
      addressController.text = enroll.enrollDetails.address;
      optionalAddressController.text =
          enroll.enrollDetails.optionalAddress ?? "";
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    addressController.dispose();
    zipCodeController.dispose();
    optionalAddressController.dispose();
    phoneNoController.dispose();
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: key,
                      child: Column(
                        children: [
                          LoanTextField(
                              autovalidateMode: AutovalidateMode.disabled,
                              check: (value) {
                                if (value!.isNotEmpty) {
                                  enrollController.validateEmail(value);
                                }
                              },
                              textType: TextInputType.emailAddress,
                              msg: "Please enter your Email",
                              labelText: "email_hint".tr,
                              myController: emailController,
                              hintText: "email_hint".tr,
                              validate: (value) {
                                // enrollController.validateEmail(value ?? "");

                                return null;
                              }),
                          Obx(() => Row(
                                children: [
                                  Icon(
                                    enrollController.emailIsValid.value
                                        ? Icons.close
                                        : Icons.check,
                                    color: enrollController.getEmailTextColor(),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "${enrollController.emailError.value}",
                                    style: TextStyle(
                                        color: enrollController
                                            .getEmailTextColor()),
                                  ),
                                ],
                              )),
                          const SizedBox(
                            height: 25.0,
                          ),
                          DropdownButtonFormField<String>(
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

                          const SizedBox(
                            height: 25,
                          ),
                          InternationalPhoneNumberInput(
                            onFieldSubmitted: (value){
                              enrollController.setPhoneNumber(value);
                            },
                            spaceBetweenSelectorAndTextField: 0,
                            hintText: "Phone Number",
                            initialValue: enrollController.number,
                            textFieldController: phoneNoController,
                            inputBorder: const OutlineInputBorder(),
                            formatInput: true,
                            errorMessage: "Invalid phone number",
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            maxLength: 15,
                            selectorConfig: const SelectorConfig(
                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter Phone Number";
                              }

                              return null;
                            },
                            countries: const ['US'],
                            onInputChanged: (PhoneNumber number) {
                              // enrollController.updatePhoneNumber(number);
                            },

                            ///hintText: 'Enter US phone number',
                          ),
                          // Obx(() => Text(
                          //     'Number Format: ${enrollController.formattedInput}')),
                          const SizedBox(
                            height: 25.0,
                          ),
                          LoanTextField(
                              check: (value) {
                                try{
                                  enrollController.setZipCode(int.parse(value!));
                                }catch(e) {
                                  if(kDebugMode) print(e.toString());
                                }
                              },
                              textType: TextInputType.number,
                              msg: "Please enter Zip Code",
                              labelText: "zip_code".tr,
                              myController: zipCodeController,
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
                            check: (value){
                              enrollController.setAddress(value!);
                            },
                              textType: TextInputType.streetAddress,
                              msg: "Please enter Your Address",
                              labelText: "home_address".tr,
                              validate: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter Complete address";
                                }
                                return null;
                              },
                              myController: addressController,
                              hintText: "home_address".tr),
                          const SizedBox(
                            height: 25.0,
                          ),
                          LoanTextField(
                            check: (value){
                              enrollController.setAddress_2(value!);
                            },
                              textType: TextInputType.streetAddress,
                              labelText: "home_address_2".tr,
                              myController: optionalAddressController,
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
                      //Get.find<EnrollController>().toggleLoading();
                      pageController.setPageNo(3);
                      enrollController.navigator(emailController.text);
                      // await Get.toNamed(RoutesName.enrollScrren3);
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
