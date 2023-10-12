import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loan_app/consts/colors.dart';
import 'package:loan_app/routes/routing.dart';
import 'package:loan_app/widgets/my_button.dart';
import 'package:loan_app/widgets/my_text_field.dart';

class MyLoginScreen extends StatefulWidget {
  const MyLoginScreen({super.key});

  @override
  State<MyLoginScreen> createState() => _MyLoginScreenState();
}

class _MyLoginScreenState extends State<MyLoginScreen> {
  final TextEditingController ct = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Text(
                  "Faundz",
                  style: TextStyle(
                      fontFamily: GoogleFonts.gorditas().fontFamily,
                      fontWeight: FontWeight.normal,
                      fontSize: 32,
                      color: mainColor),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  "We’ve missed you! Sign in to\n continue",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                      color: textGrey),
                  textAlign: TextAlign.center,
                  //textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15.0),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25.0, vertical: 15.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.65,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          MyTextFields(
                            myController: ct,
                            hintText: "Email",
                            obscureText: false,
                            
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          MyTextFields(
                            myController: ct,
                            hintText: "Password",
                            obscureText: true,
                            suffixIconData: Icons.lock,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Forget Password?",
                                style:
                                    TextStyle(color: mainColor, fontSize: 19.0),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50.0,
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: Image.asset("assets/icons/face_r.png")),
                          const SizedBox(
                            height: 30.0,
                          ),
                          MyButton(
                            text: "Sign On",
                            onTap: () {
                              Get.toNamed(Routes.loanScreen);
                            },
                          ),
                          const SizedBox(
                            height: 50.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text(
                                "New User? ",
                                style: TextStyle(fontSize: 18),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Enroll",
                                  style:
                                      TextStyle(color: mainColor, fontSize: 18),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
