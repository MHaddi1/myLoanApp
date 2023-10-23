import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main_loan_app/res/components/my_button.dart';
import 'package:main_loan_app/res/routes/routes_name.dart';
import 'package:main_loan_app/utils/utils.dart';
import 'package:main_loan_app/view_models/shared_p/shared_preference.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userPreference = UserPreference();

    return Scaffold(
      backgroundColor: Colors.blue[300],
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Get.defaultDialog(
                    title: "Logout",
                    content: const Text("Do You Want to logout"),
                    confirm: TextButton(
                        onPressed: () {
                          userPreference.clearUserToken().then((value) {
                            Get.toNamed(RoutesName.loginScrren);
                            Utils.showToastMessage("Logout Successfull..");
                          });
                        },
                        child: const Text("Yes")),
                    cancel: TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text("No")));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('loan_accounts')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!.data() as Map<String, dynamic>?;

          if (data == null) {
            return const Text("No data available");
          }

          var loanStatus = data['loan_status'];
          print(data);
          String statusText = "";
          IconData iconData = Icons.home;
          Color textColor = Colors.black;
          String message = "";
          IconData statusIcons = Icons.check_box;
          bool showReSubmitButton = false;

          if (loanStatus == 0) {
            iconData = Icons.question_mark;
            textColor = Colors.orange;
            statusText = "Pending";
            message =
                "We Are Working on Your Loan Request\n We will update your status within 7\n working days";
            statusIcons = Icons.question_answer;
          } else if (loanStatus == 1) {
            iconData = Icons.check;
            textColor = Colors.green;
            statusText = "Approval";
            message = "Approved";
            statusIcons = Icons.check_box;
          } else if (loanStatus == 2) {
            iconData = Icons.warning;
            textColor = Colors.red;
            statusText = "Rejection";
            message = "Please Recheck Your information\n and Try Again";
            statusIcons = Icons.warning;
            showReSubmitButton = true;
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  elevation: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: Get.height * 0.20,
                    width: Get.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.favorite,
                                color: Colors.blue,
                              ),
                              Icon(
                                Icons.more_vert,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              iconData,
                              color: textColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Loan Status: $statusText",
                              style: TextStyle(fontSize: 20, color: textColor),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                message,
                                style: const TextStyle(fontSize: 15),
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                              Icon(
                                statusIcons,
                                color: textColor,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //LoanTextField(myController: loanStatus.to, hintText: "", textType: TextInputType.number),
                if (showReSubmitButton)
                  MyButton(
                    text: "ReSubmit Application",
                    onTap: () {
                      Get.toNamed(RoutesName.enrollScrren1);
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
