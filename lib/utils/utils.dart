import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:main_loan_app/res/colors/color.dart';

import '../view_models/controllers/enroll_controller/enroll_controller.dart';

class Utils {
  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static void showToastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColor.feildColor,
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM,
      fontSize: 16.0,
    );
  }

  static void snackBar(String title, String message) {
    Get.snackbar(title, message,
        backgroundColor: Colors.black,
        colorText: Colors.white,
        duration: const Duration(milliseconds: 750));
  }

  static void myBoxShow(
    String title,
    String message,
  ) {
    Get.defaultDialog(
      title: title,
      contentPadding: const EdgeInsets.all(12.0),
      middleText: message,
      confirm: TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("ok")),
    );
  }

  static selectDate(BuildContext context, EnrollController controller) async {
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
