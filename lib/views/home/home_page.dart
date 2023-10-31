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

  @override
  void dispose() {
    amount.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
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
          )
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
            if (newStatus == 2) {
              //showSubmitButton = true;
            }
          } else if (loanStatus == 2) {
            iconData = Icons.warning;
            textColor = Colors.red;
            statusText = "Rejection";
            message = "Please Recheck Your information\n and Try Again";
            statusIcons = Icons.warning;
            showReSubmitButton = true;
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
                      topRight: Radius.circular(35),
                      topLeft: Radius.circular(35),
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12)),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12))),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Column(
                            children: [
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
                        if (showTextField)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: MyButton(
                              text: "Request For Loan",
                              onTap: () {
                                Get.toNamed(RoutesName.loanApplied);
                              },
                            ),
                          ),
                        if (showReSubmitButton)
                          MyButton(
                            text: newStatus == null
                                ? "ReSubmit Application"
                                : "Loan ReSubmit Application",
                            onTap: newStatus == null
                                ? () {
                                    Get.toNamed(RoutesName.enrollScrren1);
                                  }
                                : () {
                                    if (kDebugMode) {
                                      //homeController.fetchData();
                                      Get.toNamed(RoutesName.loanApplied);
                                    }
                                  },
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [],
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
      height: 200,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Name",
                style: TextStyle(fontSize: 25),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.delete,
                    color: Colors.pink,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                            )
                          ],
                          borderRadius: BorderRadius.circular(2)),
                      child: const Icon(Icons.settings))
                ],
              )
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    "\$90000",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "90000",
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "5%",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "interst",
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "\$390",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "90000",
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              )
            ],
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Company Name",
            ),
          ),
        ],
      ),
    );
  }
}
