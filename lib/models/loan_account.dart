class LoanAccount {
  final String userId;
  final int loanStatus;
  final String amount;
  final String businessName;
  final String businessAdress;
  final DateTime appliedDate;
  final String reason;
  final Map<String, dynamic> otherUserInfo;

  LoanAccount({
    required this.userId,
    required this.loanStatus,
    required this.amount,
    required this.businessName,
    required this.businessAdress,
    required this.appliedDate,
    required this.reason,
    required this.otherUserInfo,
  });

  factory LoanAccount.fromJson(Map<String, dynamic> data, String userId) {
    return LoanAccount(
      userId: userId,
      loanStatus: data['loan_status'],
      amount: data['amount'],
      businessName: data['business_name'],
      businessAdress: data['business_adress'],
      appliedDate: DateTime.parse(data['applied_date']),
      reason: data['reason'],
      otherUserInfo: data['other_user_info'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'loan_status': loanStatus,
      'amount': amount,
      'business_name': businessName,
      'business_adress': businessAdress,
      'applied_date': appliedDate.toIso8601String(),
      'reason': reason,
      'other_user_info': otherUserInfo,
    };
  }

  LoanAccount copyWith({
    String? userId,
    int? loanStatus,
    String? amount,
    String? businessName,
    String? businessAdress,
    DateTime? appliedDate, // Add due date as an optional parameter
    String? reason, // Add reason as an optional parameter
    Map<String, dynamic>? otherUserInfo,
  }) {
    return LoanAccount(
      userId: userId ?? this.userId,
      loanStatus: loanStatus ?? this.loanStatus,
      amount: amount ?? this.amount,
      businessName: businessName ?? this.businessName,
      businessAdress: businessAdress ?? this.businessAdress,
      appliedDate: appliedDate ?? this.appliedDate, // Update the due date
      reason: reason ?? this.reason, // Update the reason
      otherUserInfo: otherUserInfo ?? this.otherUserInfo,
    );
  }

  // Method to update the amount
  LoanAccount updateAmount(String newAmount) {
    return copyWith(amount: newAmount);
  }

  // Method to update the due date
  LoanAccount updateappliedDate(DateTime newappliedDate) {
    return copyWith(appliedDate: newappliedDate);
  }

  @override
  String toString() {
    return 'LoanAccount{userId: $userId, loanStatus: $loanStatus, amount: $amount, businessName: $businessName, businessAddress: $businessAdress, appliedDate: $appliedDate, reason: $reason, otherUserInfo: $otherUserInfo}';
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
          appliedDate ==
              other.appliedDate && // Include appliedDate in comparison
          reason == other.reason && // Include reason in comparison
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
      otherUserInfo.hashCode;
}
