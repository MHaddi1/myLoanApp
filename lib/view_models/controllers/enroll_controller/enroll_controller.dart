import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:main_loan_app/models/enroll_model.dart';
import 'package:main_loan_app/models/enrolldetails_model.dart';
import 'package:main_loan_app/models/enroll_living_detail_model.dart';
import 'package:main_loan_app/models/enrolluser_model.dart';
import 'package:main_loan_app/models/moredetail_model.dart';
import 'package:main_loan_app/res/routes/routes_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:main_loan_app/utils/utils.dart';

class EnrollController extends GetxController {
  FocusNode focusNode = FocusNode();

  RxString countryValue = ''.obs;
  RxString stateValue = ''.obs;
  RxString cityValue = ''.obs;
  RxBool isFirstRadioSelected = true.obs;
  var phoneNumberIsValid = false.obs;
  var formattedPhoneNumber = ''.obs;

  final CollectionReference collection =
      FirebaseFirestore.instance.collection('enrollments');

  Rx<DateTime> selectedDate = DateTime.now().obs;

  var selectedItem = 'Phone Number'.obs;
  var selectedItem2 = 'Execution, Profesional, semi Pro'.obs;
  var selectedItem3 = 'Resident-Alien'.obs;
  var selectedItem4 = 'Driver Lic/State ID'.obs;

  PhoneNumber? number;
  RxString phoneNumber = ''.obs;

  RxString password = ''.obs;
  RxString confirmPassword = ''.obs;
  var passwordError = Rx<String?>('');

  myPassword(String value) {
    password.value = value;
  }

  cMyPassword(String value) {
    confirmPassword.value = value;
    if (value == password.value) {
      passwordError.value = "password Matched";
    } else if (value.length == password.value.length) {
      passwordError.value = "Password and Confirm is Not Matched";
    } else if (value.length >= 6 && value.length <= 15) {
      passwordError.value =
          "your Password Must be Greater or equal to 6\n less then or equal to 15";
    } else {
      passwordError.value = "Password or Lenght mismatch";
    }
  }

  var isLoading = false.obs;

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }
  // var userInput = ''.obs;
  // var formattedInput = ''.obs;

  // void updateInput(String input) {
  //   userInput.value = input;
  //   String formatted = '';
  //   for (int i = 0; i < input.length; i++) {
  //     formatted += input[i];
  //     if (i == 8) {
  //       formatted += '-';
  //     }
  //   }
  //   formattedInput.value = formatted;
  //   phoneNoController.text = formattedInput.value;
  // }

  // void updatePhoneNumber(PhoneNumber phoneNumber) {
  //   number = phoneNumber;
  //   PhoneNumber(isoCode: 'US', phoneNumber: number.toString());
  // }
  RxString fname = ''.obs;
  RxString lname = ''.obs;
  RxString mname = ''.obs;
  RxString dob = ''.obs;
  RxInt zipcode = 0.obs;
  RxString address1 = ''.obs;
  RxString addressO = ''.obs;
  RxString personalNumber = ''.obs;
  RxString detailNumber = ''.obs;

  void setFName(String firstName) {
    fname.value = firstName;
  }

  void setLName(String lastName) {
    lname.value = lastName;
  }

  void setMiddle(String middleName) {
    mname.value = middleName;
  }

  void setDate(String dOb) {
    dob.value = dOb;
  }

  void setZipCode(int value) {
    zipcode.value = value;
  }

  void setAddress(String value) {
    address1.value = value;
  }

  void setAddress_2(String value) {
    addressO.value = value;
  }

  void setPhoneNumber(String value) {
    phoneNumber.value = value;
  }

  void setPersonalNumber(String value) {
    personalNumber.value = value;
  }

  void setDetailNumber(String value) {
    detailNumber.value = value;
  }

  var emailIsValid = RxBool(false);
  var email = ''.obs;
  var emailError = Rx<String?>('');

  void validateEmail(String value) {
    email.value = value;
    if (value.isEmpty) {
      emailIsValid.value = false;
      emailError.value = 'Email is required';
    } else if (!value.isEmail) {
      emailIsValid.value = false;
      emailError.value = 'Enter a valid email';
    } else {
      emailIsValid.value = true;
      emailError.value = "email is vaild";
    }
  }

  Color getEmailTextColor() {
    return emailIsValid.value ? Colors.green : Colors.red;
  }

  navigator(String email) {
    if (email.isEmail) {
      Get.toNamed(RoutesName.enrollScrren3);
    } else {}
  }

  // bool isPhoneNumberValid(String value) {
  //   final phoneRegex = RegExp(r'^\(\d{3}\) \d{3}-\d{4}$');

  //   return phoneRegex.hasMatch(value);
  // }

  updateCountry(String value) {
    countryValue.value = value;
  }

  updateState(String value) {
    stateValue.value = value;
  }

  updateCity(String value) {
    cityValue.value = value;
  }

  setSelectedItem(String newValue) {
    selectedItem.value = newValue;
  }

  setSelectedItem2(String newValue) {
    selectedItem2.value = newValue;
  }

  setSelectedItem3(String newValue) {
    selectedItem3.value = newValue;
  }

  setSelectedItem4(String newValue) {
    selectedItem4.value = newValue;
  }

  void toggleRadio(bool value) {
    isFirstRadioSelected.value = value;
  }

  dataTake() {
    return countryValue.value;
  }

  // void checkEmail() {
  //   String email = emailController.text;

  //   if (isEmailValid(email)) {
  //     Get.snackbar("Email Valid", "The email is valid.");
  //   } else {
  //     Get.snackbar("Email Invalid", "The email is invalid.");
  //   }
  // }

  void selectDate(DateTime date) {
    selectedDate.value = date;
  }

  bool isEmailValid(String email) {
    if (email.isEmail) {
      return true;
    }
    return false;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addEnrollData(Enroll enroll) async {
    try {
      final Map<String, dynamic> enrollData = enroll.toJson();

      await _firestore
          .collection('enrollments')
          .add(enrollData)
          .then((DocumentReference documentReference) {
        if (kDebugMode) {
          print(documentReference.id);
        }
      });

      Get.snackbar("Success", "Data added to Firestore successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } catch (error) {
      Get.snackbar(
        "Error",
        "Failed to add data to Firestore: $error",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> updateEnrollData(String documentId, Enroll enroll) async {
    try {
      final Map<String, dynamic> enrollData = enroll.toJson();

      await _firestore
          .collection('enrollments')
          .doc(documentId)
          .update(enrollData);

      Get.snackbar("Success", "Data updated in Firestore successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } catch (error) {
      Get.snackbar(
        "Error",
        "Failed to update data in Firestore: $error",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  String get country => countryValue.value;
  String get city => cityValue.value;
  String get state => stateValue.value;
  String get phn => selectedItem.value;
  String get worktype => selectedItem2.value;
  String get living => selectedItem3.value;
  String get idNumber => selectedItem4.value;
  String get eMail => email.value;
  String get phoneNo => phoneNumber.value;
  String get fName => fname.value;
  String get lName => lname.value;
  String get mName => mname.value;
  String get myDOB => dob.value;
  String get aDDress => address1.value;
  String get aDDressO => addressO.value;
  int get zipCode => zipcode.value;
  String get myNumber => personalNumber.value;
  String get myDetailNumber => detailNumber.value;
  String get pass => password.value;

  void onAddEnrollData() async {
    Enroll enroll = Enroll(
      user: EnrollUser(
        fname: fName,
        lname: lName,
        middleName: mName,
        dob: myDOB,
      ),
      enrollDetails: EnrollDetails(
          email: eMail,
          phoneType: phn,
          phone: phoneNo,
          zipcode: int.parse(zipCode.toString()),
          address: aDDress,
          optionalAddress: aDDressO),
      enrollLiving: EnrollLiving(
        country: country,
        state: state,
        city: city,
        jobT: worktype,
        livingPlace: living,
        ssn: myNumber,
        itin: myNumber,
      ),
      moreDetails: MoreDetails(
        numbersDetail: myDetailNumber,
        idType: idNumber,
        state: state,
        issuedDate: '12/12/2023',
      ),
    );
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      var collectionReference =
          FirebaseFirestore.instance.collection("enrollments");
      var allData = await collectionReference.get();
      var dId = allData.docs.last.id;

      final user = firebaseAuth.currentUser;
      if (user != null) {
        updateEnrollData(dId, enroll);
      } else {
        addEnrollData(enroll);
        createUserAccount(eMail, pass);
      }
    } catch (e) {
      _debugPrint(e.toString());
    }
  }

  Future<void> createUserAccount(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (kDebugMode) {
        print("Create Account");
      }

      await FirebaseFirestore.instance
          .collection('loan_accounts')
          .doc(userCredential.user!.uid)
          .set({
        'loan_status': 0,
      }).then((value) => Utils.snackBar("Data Submit", "Check You Status"));
    } catch (e) {
      Utils.snackBar("error", e.toString());
    }
  }

  Future<void> updateLoanStatus(String userId, int newStatus) async {
    try {
      await FirebaseFirestore.instance
          .collection('loan_accounts')
          .doc(userId)
          .update({
        'loan_status': newStatus,
      });
    } catch (e) {
      Utils.snackBar("error", e.toString());
    }
  }

//  Future<void> populateTextFieldsFromFirebase(String documentId,) async {
//     try {
//       final documentSnapshot =
//           await FirebaseFirestore.instance.collection('enrollments').doc(documentId).get();

//       if (documentSnapshot.exists) {
//         final data = documentSnapshot.data() as Map<dynamic, dynamic>;

//         usernameController.text = data['fname'] ?? 'You Name';
//         middleNameController.text = data['middleName'] ?? '';
//         lastNameController.text = data['lname'] ?? '';
//         dateOfBirthController.text = data['dob'] ?? '';
//         emailController.text = data['email'] ?? '';
//         phoneNoController.text = data['phone'] ?? '';
//         //phn = data['phoneType'] ?? '';
//         zipCodeController.text = data['zipcode'] ?? '';
//         addressController.text = data['address'] ?? '';
//         optionalAddressController.text = data['optionalAddress'] ?? '';

//       } else {
//         Get.snackbar("Error", "Document not found in Firestore");
//       }
//     } catch (error) {
//       print(error.toString());
//       Get.snackbar("Error", "Failed to fetch data from Firestore: $error");
//     }
//   }

  Future<String?> getDocumentIdFromFirebase(String searchEmail) async {
    isLoading.value = true;

    final QuerySnapshot querySnapshot = await collection.get();
    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.id;
    }

    return null;
  }

  final Rx<Enroll?> enroll = Rx<Enroll?>(null);

  Future<void> fetchData() async {
    //isLoading.value = true;
    var collectionReference =
        FirebaseFirestore.instance.collection("enrollments");
    var allData = await collectionReference.get();
    var dId = allData.docs.last.id;
    try {
      final docSnapshot =
          await _firestore.collection('enrollments').doc(dId).get();
      _debugPrint('Doc Snapshot ${docSnapshot.data()}');

      if (docSnapshot.exists) {
        final response = Enroll.fromJson(
          docSnapshot.data() as Map<String, dynamic>,
        );
        enroll.value = response;
        if (enroll.value != null) {
          setFName(enroll.value!.user.fname);
          setLName(enroll.value!.user.lname);
          setMiddle(enroll.value!.user.middleName!);
          setDate(enroll.value!.user.dob);
          validateEmail(enroll.value!.enrollDetails.email);
          setPhoneNumber(enroll.value!.enrollDetails.phone);
          setZipCode(enroll.value!.enrollDetails.zipcode);
          setAddress(enroll.value!.enrollDetails.address);
          setAddress_2(enroll.value!.enrollDetails.optionalAddress!);
          updateCountry(enroll.value!.enrollLiving.country);
          updateState(enroll.value!.enrollLiving.state);
          updateCity(enroll.value!.enrollLiving.city);
          setDetailNumber(enroll.value!.enrollLiving.ssn!);
          setDetailNumber(enroll.value!.enrollLiving.itin!);
        }
      } else {
        _debugPrint("Document not exists");
      }
    } catch (e) {
      _debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}

void _debugPrint(message) {
  if (kDebugMode) print(message);
}
