import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main_loan_app/res/components/my_button.dart';
import 'package:main_loan_app/res/routes/routes_name.dart';
import 'package:main_loan_app/utils/utils.dart';
import 'package:main_loan_app/view_models/controllers/enroll_controller/enroll_controller.dart';
import 'package:main_loan_app/view_models/controllers/home_controller/home_controller.dart';
import 'package:main_loan_app/view_models/shared_p/shared_preference.dart';
import 'package:main_loan_app/views/splash_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final enrollController = Get.find<EnrollController>();
  final homeController = Get.put(HomeController());
  final amount = TextEditingController();
  var statusText = "";
  IconData iconData = Icons.home;
  Color textColor = Colors.black;
  String message = "";
  IconData statusIcons = Icons.check_box;
  bool showReSubmitButton = false;
  bool showTextField = false;

  void refresh() {
    setState(() {
      Get.offAndToNamed(RoutesName.splashScreen);
    });
  }

  @override
  void dispose() {
    amount.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    //refresh();
    enrollController.fetchData();
    homeController.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final userPreference = UserPreference();

    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        leading: const Icon(null),
        actions: [
          IconButton(
            onPressed: () {
              Get.defaultDialog(
                title: "Logout",
                content: const Text("Do You Want to logout"),
                confirm: TextButton(
                  onPressed: () {
                    userPreference.clearUserToken().then((value) {
                      Get.offAllNamed(RoutesName.loginScrren);
                      Utils.showToastMessage("Logout Successful..");
                    });
                  },
                  child: const Text("Yes"),
                ),
                cancel: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("No"),
                ),
              );
            },
            icon: const Icon(Icons.logout),
          ),
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
          var newStatus = data['new_status'];

          if (newStatus != null) {
            loanStatus = newStatus;
            print(loanStatus);
          }

          //bool showSubmitButton = false;

          if (loanStatus == 0) {
            iconData = Icons.question_mark;
            textColor = Colors.orange;
            statusText = "Pending";
            message =
                "We Are Working on Your Loan Request\nWe will update your status within 7\nworking days";
            statusIcons = Icons.question_answer;
          } else if (loanStatus == 1) {
            iconData = Icons.check;
            textColor = Colors.green;
            statusText = "Approval";
            message = "Approved";
            statusIcons = Icons.check_box;
            showTextField = true;
            showReSubmitButton = false;
            if (newStatus == 2) {
              //showSubmitButton = true;
            }
          } else if (loanStatus == 2) {
            iconData = const IconData(0xf07ec, fontFamily: 'MaterialIcons');
            textColor = Colors.red;
            statusText = "Rejection";
            message = "Please Recheck Your information\n and Try Again";
            statusIcons = Icons.warning;
            showReSubmitButton = true;
            showTextField = true;
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Icon(
                        //   Icons.favorite,
                        //   color: Colors.blue,
                        // ),
                        // Icon(
                        //   Icons.more_vert,
                        //   color: Colors.blue,
                        // ),
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
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          message,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white),
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
                  newStatus == 1
                      ? Text(
                          "Cradit: ${data['amount']}",
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )
                      : const SizedBox(),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.bottomCenter,
                height: MediaQuery.of(context).size.height * 0.67,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12)),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12))),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Name"),
                                  Row(
                                    children: [Text("Total:"), Text("\$18000")],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              MyCardDetail(),
                              SizedBox(
                                height: 20,
                              ),
                              MyCardDetail(),
                              SizedBox(
                                height: 20,
                              ),
                              MyCardDetail()
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          child: Column(
                            children: [
                              // showTextField
                              //     ? const SizedBox()
                              //     : Padding(
                              //         padding: const EdgeInsets.symmetric(
                              //             horizontal: 15, vertical: 10),
                              //         child: MyButton(
                              //           text: "Request For Loan",
                              //           onTap: () {
                              //             Get.toNamed(RoutesName.loanApplied);
                              //           },
                              //         ),
                              //       ),
                              if (showReSubmitButton || showTextField)
                                if (newStatus == null) ...[
                                  if (loanStatus == 1)
                                    MyButton(
                                      text: "Request For loan",
                                      onTap: () {
                                        Get.toNamed(RoutesName.loanApplied);
                                      },
                                    ),
                                  if (loanStatus == 2)
                                    MyButton(
                                      text: "Loan ReSubmit Application",
                                      onTap: () {
                                        Get.toNamed(RoutesName.enrollScrren1);
                                      },
                                    )
                                ] else ...[
                                  if (newStatus == 0 || newStatus == 1)
                                    const SizedBox()
                                  else
                                    MyButton(
                                      text: "ReSubmit Loan Application",
                                      onTap: () {
                                        Get.toNamed(RoutesName.loanApplied);
                                      },
                                    ),
                                ]
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class MyCardDetail extends StatelessWidget {
  const MyCardDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      height: Get.height * 0.25,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 2,
            )
          ]),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Name",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    "\$90000",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "90000",
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "5%",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "interst",
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "\$390",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "monthly Payment",
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              )
            ],
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Company Name",
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
