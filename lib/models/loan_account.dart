class LoanAccount {
  final String userId;
  final int loanStatus;
  final int amount;
  final String businessName;
  final String businessAdress;
  final DateTime appliedDate;
  final String reason;
  final int newStatus; // Change newStatus to int
  final Map<String, dynamic> otherUserInfo;

  LoanAccount({
    required this.userId,
    required this.loanStatus,
    required this.amount,
    required this.businessName,
    required this.businessAdress,
    required this.appliedDate,
    required this.reason,
    required this.newStatus, // Include newStatus in the constructor as int
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
      newStatus: data['new_status'], // Parse newStatus from JSON as int
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
      'new_status': newStatus, // Include newStatus in the JSON output as int
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
    int? newStatus, // Include newStatus as an optional parameter as int
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
      newStatus: newStatus ?? this.newStatus, // Update newStatus as int
      otherUserInfo: otherUserInfo ?? this.otherUserInfo,
    );
  }

  // Method to update the amount
  LoanAccount updateAmount(int newAmount) {
    return copyWith(amount: newAmount);
  }

  // Method to update the due date
  LoanAccount updateappliedDate(DateTime newappliedDate) {
    return copyWith(appliedDate: newappliedDate);
  }

  // Method to update the new status
  LoanAccount updateNewStatus(int newNewStatus) {
    return copyWith(newStatus: newNewStatus);
  }

  @override
  String toString() {
    return 'LoanAccount{userId: $userId, loanStatus: $loanStatus, amount: $amount, businessName: $businessName, businessAddress: $businessAdress, appliedDate: $appliedDate, reason: $reason, newStatus: $newStatus, otherUserInfo: $otherUserInfo}';
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
      otherUserInfo.hashCode;
}
