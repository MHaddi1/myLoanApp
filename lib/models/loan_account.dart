import 'package:cloud_firestore/cloud_firestore.dart';

class LoanAccount {
  final String? userId;
  final int? loanStatus;
  final int? amount;
  final String? businessName;
  final String? businessAdress;
  final DateTime? appliedDate;
  final String? reason;
  final int? newStatus;
  final double interestRate;
  final Map<String, dynamic> otherUserInfo;

  LoanAccount({
    required this.userId,
    required this.loanStatus,
    required this.amount,
    required this.businessName,
    required this.businessAdress,
    required this.appliedDate,
    required this.reason,
    required this.newStatus,
    required this.interestRate,
    required this.otherUserInfo,
  });

  factory LoanAccount.fromJson(Map<String, dynamic> data) {
    return LoanAccount(
      loanStatus: data['loan_status'] as int? ?? 0,
      amount: data['amount'] as int? ?? 0,
      businessName: data['business_name'] as String? ?? "",
      businessAdress: data['business_address'] as String? ?? "",
      appliedDate:
          (data['applied_date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      reason: data['reason'] as String? ?? "",
      newStatus: data['new_status'] as int? ?? 0,
      interestRate: data['interest_rate'] as double? ?? 0.0,
      otherUserInfo: data['other_user_info'] as Map<String, dynamic>? ?? {},
      userId: data['user_id'] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'loan_status': loanStatus,
      'amount': amount,
      'business_name': businessName,
      'business_address': businessAdress,
      'applied_date': appliedDate!.toIso8601String(),
      'reason': reason,
      'new_status': newStatus,
      'interest_rate': interestRate,
      'other_user_info': otherUserInfo,
    };
  }

  LoanAccount copyWith({
    String? userId,
    int? loanStatus,
    int? amount,
    String? businessName,
    String? businessAdress,
    DateTime? appliedDate,
    String? reason,
    double? interestRate,
    int? newStatus,
    Map<String, dynamic>? otherUserInfo,
  }) {
    return LoanAccount(
      userId: userId ?? this.userId,
      loanStatus: loanStatus ?? this.loanStatus,
      amount: amount ?? this.amount,
      businessName: businessName ?? this.businessName,
      businessAdress: businessAdress ?? this.businessAdress,
      appliedDate: appliedDate ?? this.appliedDate,
      reason: reason ?? this.reason,
      newStatus: newStatus ?? this.newStatus,
      interestRate: interestRate ?? this.interestRate,
      otherUserInfo: otherUserInfo ?? this.otherUserInfo,
    );
  }

  LoanAccount updateAmount(int newAmount) {
    return copyWith(amount: newAmount);
  }

  LoanAccount updateAppliedDate(DateTime newAppliedDate) {
    return copyWith(appliedDate: newAppliedDate);
  }

  LoanAccount updateNewStatus(int newNewStatus) {
    return copyWith(newStatus: newNewStatus);
  }

  @override
  String toString() {
    return 'LoanAccount{userId: $userId, loanStatus: $loanStatus, amount: $amount, businessName: $businessName, businessAdress: $businessAdress, appliedDate: $appliedDate, reason: $reason, newStatus: $newStatus, interestRate: $interestRate, otherUserInfo: $otherUserInfo}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoanAccount &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          loanStatus == other.loanStatus &&
          amount == other.amount &&
          businessName == other.businessName &&
          businessAdress == other.businessAdress &&
          appliedDate == other.appliedDate &&
          reason == other.reason &&
          newStatus == other.newStatus &&
          interestRate == other.interestRate &&
          otherUserInfo == other.otherUserInfo;

  @override
  int get hashCode =>
      userId.hashCode ^
      loanStatus.hashCode ^
      amount.hashCode ^
      businessName.hashCode ^
      businessAdress.hashCode ^
      appliedDate.hashCode ^
      reason.hashCode ^
      newStatus.hashCode ^
      interestRate.hashCode ^
      otherUserInfo.hashCode;
}
