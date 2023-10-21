import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:main_loan_app/res/colors/color.dart';
import 'package:main_loan_app/view_models/controllers/enroll_controller/enroll_controller.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  MyButton({
    Key? key,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call(); // Call the onTap callback
      },
      child: Container(
        padding: const EdgeInsets.all(25.0),
        decoration: BoxDecoration(
          color: AppColor.mainColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Center(
          child: Obx(() {
            final isLoading = Get.put(EnrollController()).isLoading.value;
            return isLoading
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : Text(
                    text,
                    style: const TextStyle(color: Colors.white),
                  );
          }),
        ),
      ),
    );
  }
}
