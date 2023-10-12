import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  static const spUsernameKey = "usernames";
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  RxBool isShowPassword = true.obs;
  RxBool saveUsername = false.obs;

  final List<String> suggestedUsernames =
      []; // List to hold suggested usernames
  final RxBool showSuggestions = false.obs;

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  showPassword() {
    isShowPassword.value = !isShowPassword.value;
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
}
