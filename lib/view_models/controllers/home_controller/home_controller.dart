import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:main_loan_app/models/loan_account.dart';
import 'package:main_loan_app/utils/utils.dart';

class HomeController extends GetxController {
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxString businessNames = ''.obs;
  RxString businessAddress = ''.obs;
  RxString amount = ''.obs;
  RxString reason = ''.obs;
  RxString selectedItem2 = '5 Year'.obs;
  RxString interest = ''.obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void selectDate(DateTime date) {
    selectedDate.value = date;
  }

  void businessName(String business) {
    businessNames.value = business;
  }

  void setbusinessAddress(String address) {
    businessAddress.value = address;
  }

  void setAmount(String amount) {
    this.amount.value = amount;
  }

  void setReason(String reason) {
    this.reason.value = reason;
  }

  void setSelectedItem2(String selectedItem2) {
    this.selectedItem2.value = selectedItem2;
  }

  DateTime get appliedDate => selectedDate.value;
  String get mybusinessName => businessNames.value;
  String get mybusinessAddress => businessAddress.value;
  String get myAmount => amount.value;
  String get myReason => reason.value;
  String get mySelectedItem2 => selectedItem2.value;

  myMessage() {
    if (mySelectedItem2 == "5 Year") {
      interest.value = "Your Interest rate is 5%";
    } else {
      interest.value = "Your Interest rate is 10%";
    }
  }

  Future<void> updateAmount(String documentId, LoanAccount loanAccount) async {
    try {
      await _firestore.collection('loan_accounts').doc(documentId).update({
        'amount': loanAccount.amount,
        'applied_date': loanAccount.appliedDate,
        'business_name': loanAccount.businessName,
        'business_address': loanAccount.businessAdress,
        'reason': loanAccount.reason
      });
      Utils.snackBar("Success", "Amount updated in Firestore successfully");
    } catch (e) {
      Utils.snackBar("Error", "Failed to update amount in Firestore: $e");
    }
  }

  void addLoanAmount() async {
    // DateTime appliedDate =
    //     DateTime(2000, 12, 12); // Create a DateTime object for the due date

    LoanAccount loanAccount = LoanAccount(
      userId: "123456",
      loanStatus: 1,
      amount: myAmount,
      businessName: mybusinessName,
      businessAdress: mybusinessAddress,
      appliedDate: appliedDate,
      reason: myReason,
      otherUserInfo: {
        'name': '',
        'phone': '',
        'email': '',
        'address': '',
        'city': '',
        'country': '',
        'pincode': '',
      },
    );
    var collectionReference =
        FirebaseFirestore.instance.collection("loan_accounts");
    var allData = await collectionReference.get();
    var dId = allData.docs.last.id;
    updateAmount(dId, loanAccount);
  }
}
