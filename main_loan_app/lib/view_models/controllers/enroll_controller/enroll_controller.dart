import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class EnrollController extends GetxController {
  final usernameController = TextEditingController();
  final middleNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNoController = TextEditingController();
  final cityController = TextEditingController();
  final zipCodeController = TextEditingController();
  final addressController = TextEditingController();
  final optionalAddressController = TextEditingController();
  final ssnController = TextEditingController();
  final itinController = TextEditingController();
  final idNubmerController = TextEditingController();
  final erpirationController = TextEditingController();

  @override
  void onClose() {
    // TODO: implement onClose

    usernameController.dispose();
    emailController.dispose();
    middleNameController.dispose();
    lastNameController.dispose();
    dateOfBirthController.dispose();
    cityController.dispose();
    addressController.dispose();
    optionalAddressController.dispose();
    idNubmerController.dispose();
    itinController.dispose();
    erpirationController.dispose();
    ssnController.dispose();
    phoneNoController.dispose();
  }

  RxString countryValue = ''.obs;
  RxString stateValue = ''.obs;
  RxString cityValue = ''.obs;
  RxBool isFirstRadioSelected = true.obs;

  Rx<DateTime> selectedDate = DateTime.now().obs;

  var selectedItem = 'Phone Number'.obs;
  var selectedItem2 = 'Execution, Profesional, semi Pro'.obs;
  var selectedItem3 = 'Resident-Alien'.obs;
  var selectedItem4 = 'Driver Lic/State ID'.obs;
  RxString phoneNumber = ''.obs;
  RxInt pageCounts = 1.obs;

  pageCount() {
    pageCounts += 1;
  }

  void setPhoneNumber(String value) {
    phoneNumber.value = value;
  }

  bool isPhoneNumberValid(String value) {
    final phoneRegex = RegExp(r'^\(\d{3}\) \d{3}-\d{4}$');

    return phoneRegex.hasMatch(value);
  }

  void updateCountry(String value) {
    countryValue.value = value;
  }

  void updateState(String value) {
    stateValue.value = value;
  }

  void updateCity(String value) {
    cityValue.value = value;
  }

  setSelectedItem(String newValue) {
    selectedItem.value = newValue;
  }

  void toggleRadio(bool value) {
    isFirstRadioSelected.value = value;
  }

  dataTake() {
    return countryValue.value;
  }

  void checkEmail() {
    String email = emailController.text;

    if (isEmailValid(email)) {
      Get.snackbar("Email Valid", "The email is valid.");
    } else {
      Get.snackbar("Email Invalid", "The email is invalid.");
    }
  }

  void selectDate(DateTime date) {
    selectedDate.value = date;
  }

  bool isEmailValid(String email) {
    if (email.isEmail) {
      return true;
    }
    return false;
  }
}
