import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_app/consts/colors.dart';
import 'package:loan_app/widgets/my_button.dart';
import 'package:loan_app/widgets/my_document.dart';
import 'package:loan_app/widgets/my_text_container.dart';

class AddDoument extends StatelessWidget {
  const AddDoument({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: back,
      appBar: AppBar(
        backgroundColor: back,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15),
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
                height: MediaQuery.of(context).size.height * 0.85,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      MyTextContainer(title: "Bank Statement"),
                      SizedBox(
                        height: 10,
                      ),
                      MyDoumnent(
                          title: "click here to upload bank statement",
                          ficonData: Icons.cloud_upload,
                          siconData: "assets/icons/question.png"),
                      SizedBox(
                        height: 30,
                      ),
                      MyTextContainer(title: "CAC Document"),
                      SizedBox(
                        height: 10,
                      ),
                      MyDoumnent(
                          title:
                              "click here to upload Certificate of Incorporation",
                          ficonData: Icons.cloud_upload,
                          siconData: "assets/icons/question.png"),
                      SizedBox(
                        height: 30,
                      ),
                      MyTextContainer(title: "Govt ID"),
                      SizedBox(
                        height: 10,
                      ),
                      MyDoumnent(
                          title: "click here to upload GOVT issued ID",
                          ficonData: Icons.cloud_upload,
                          siconData: "assets/icons/question.png"),
                      SizedBox(
                        height: 30,
                      ),
                      MyTextContainer(title: "Address Verification"),
                      SizedBox(
                        height: 10,
                      ),
                      MyDoumnent(
                          title: "click here to upload address verification",
                          ficonData: Icons.cloud_upload,
                          siconData: "assets/icons/question.png"),
                      SizedBox(
                        height: 100,
                      ),
                      MyButton(text: "Proced")
                    ],
                  ),
                ))),
      ),
    );
  }
}
