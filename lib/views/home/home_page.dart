import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main_loan_app/res/components/my_button.dart';
import 'package:main_loan_app/res/routes/routes_name.dart';
import 'package:main_loan_app/utils/utils.dart';
import 'package:main_loan_app/view_models/controllers/enroll_controller/enroll_controller.dart';
import 'package:main_loan_app/view_models/controllers/home_controller/home_controller.dart';
import 'package:main_loan_app/view_models/shared_p/shared_preference.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final enrollController = Get.find<EnrollController>();
  final homeController = Get.put(HomeController());
  final amount = TextEditingController();

  @override
  void dispose() {
    amount.dispose();
    amount.clear();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    enrollController.fetchData();
  }

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
          bool showTextField = false;

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
            showTextField = true;
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
                        Text("Your Cradit: ${data['amount']}\$"),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: Get.height * 0.30,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 4,
                          blurRadius: 3,
                          offset: const Offset(0, 3),
                        ),
                      ]),
                  child: const SingleChildScrollView(
                    child: Column(
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.end,
                        //     children: [
                        //       SizedBox(
                        //         height: Get.height * 0.05,
                        //       ),
                        //       if (showTextField)
                        //         Container(
                        //           decoration: BoxDecoration(
                        //             color: Colors.white,
                        //             borderRadius: BorderRadius.circular(12),
                        //             boxShadow: const [
                        //               BoxShadow(
                        //                 color: Colors.black45,
                        //                 blurRadius: 6,
                        //                 offset: Offset(0, 2),
                        //               ),
                        //             ],
                        //           ),
                        //           alignment: Alignment.topCenter,
                        //           child: LoanTextField(
                        //             maxLength: 4,
                        //             suffixIconData: Icons.monetization_on_outlined,
                        //             myController: amount,
                        //             hintText: 'Enter Amount',
                        //             textType: TextInputType.number,
                        //           ),
                        //         ),

                        //       const SizedBox(
                        //         height: 15,
                        //       ),
                        //       MyButton(
                        //         text: "Submit You Amount",
                        //         onTap: () async {
                        //           String myAmount = amount.text;
                        //           var collectionReference = FirebaseFirestore
                        //               .instance
                        //               .collection("loan_accounts");
                        //           var allData = await collectionReference.get();

                        //           if (allData.docs.isNotEmpty) {

                        //             var dId = allData.docs.last.id;

                        //             homeController.updateAmount(dId, myAmount);

                        //             showTextField = false;
                        //           } else {

                        //             print(
                        //                 "The 'loan_amounts' collection is empty.");
                        //           }
                        //         },
                        //       ),
                        //     ],
                        //   ),
                        // ),

                        //LoanTextField(myController: loanStatus.to, hintText: "", textType: TextInputType.number),
                      ],
                    ),
                  ),
                ),
                if (showTextField)
                  MyButton(
                    text: "Request For Loan",
                    onTap: () {
                      Get.toNamed(RoutesName.loanApplied);
                    },
                  ),
                if (showReSubmitButton)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MyButton(
                        text: "ReSubmit Application",
                        onTap: () {
                          Get.toNamed(RoutesName.enrollScrren1);
                        },
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
