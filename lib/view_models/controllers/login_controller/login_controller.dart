import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:main_loan_app/utils/utils.dart';
import 'package:main_loan_app/view_models/shared_p/shared_preference.dart';
import 'package:main_loan_app/views/home/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  static const spUsernameKey = "usernames";
  

  RxBool isShowPassword = true.obs;
  RxBool saveUsername = false.obs;

  var username = ''.obs;
  var password = ''.obs;
  var isEmailValid = false.obs;
  var isPasswordValid = false.obs;
  var errorMessageEmail = Rx<String?>('');
  var errorMessagePassword = Rx<String?>('');

  final List<String> suggestedUsernames =
      []; // List to hold suggested usernames
  final RxBool showSuggestions = false.obs;



  showPassword() {
    isShowPassword.value = !isShowPassword.value;
  }

  userNameValidation(String value, int minlength, int maxlength) {
    username.value = value;
    // if (value.isEmpty) {
    //   errorMessageEmail.value = "username cannot be empty";
    // }
    if (value.isNotEmpty) {
      if (value.length >= minlength && value.length < maxlength) {
        errorMessageEmail.value = null;
      } else {
        errorMessageEmail.value =
            "UserName Lenght is less then $minlength and greater than $maxlength";
      }
    }
    return null;
  }

  passwordValidation(String value, int minlength, int maxlength) {
    password.value = value;
    if (value.isEmpty) {
      errorMessagePassword.value = "password cannot be empty";
    } else {
      if (value.length >= minlength && value.length < maxlength) {
        errorMessagePassword.value = null;
      } else {
        errorMessagePassword.value =
            "Password Lenght is less then $minlength and greater than $maxlength";
      }
    }
  }

  Future<void> saveUsernames(String username) async {
    final prefs = await SharedPreferences.getInstance();
    final getAll = await getSavedUsername();
    getAll.removeWhere((user) => user == username);
    getAll.add(username);
    await prefs.setString(spUsernameKey, jsonEncode(getAll));
    if (kDebugMode) {
      print(getAll.toString());
    }
  }

  Future<List<String>> getSavedUsername() async {
    final prefs = await SharedPreferences.getInstance();
    if (kDebugMode) {
      print("working...!");
    }
    final data = prefs.getString(spUsernameKey);
    if (data == null) return [];
    return List<String>.from(jsonDecode(data));
  }

   final FirebaseAuth _auth = FirebaseAuth.instance;

  var errorText = ''.obs;

  Future<void> signIn(String email, String password) async {
    try {
        final UserPreference userPreference = UserPreference();
String? userToken = await FirebaseAuth.instance.currentUser?.getIdToken();
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ).then((value){
         userPreference.saveUserToken(userToken!).then((value){
          Utils.snackBar("Save", "User");
         });
      });

      Get.offAll(()=> const HomePage());
    } on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found' || e.code == 'wrong-password') {
    Utils.snackBar("error", e.toString());
    errorText.value = 'Invalid email or password.';
  } else if(e.code == 'INVALID_LOGIN_CREDENTIALS'){
    errorText.value = "InValid User Login";
    Utils.snackBar("error", "User Not Found");

  }
   else {
    // Handle other FirebaseAuth errors
    errorText.value = e.message ?? 'An error occurred.';
  }
} catch (e) {
  errorText.value = e.toString();
}
  } 
}
