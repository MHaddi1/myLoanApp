class LoanAccount {
  final String userId;
  final int loanStatus;
  final Map<String, dynamic> otherUserInfo; // You can add other user information here

  LoanAccount({
    required this.userId,
    required this.loanStatus,
    required this.otherUserInfo,
  });

  factory LoanAccount.fromJson(Map<String, dynamic> data, String userId) {
    return LoanAccount(
      userId: userId,
      loanStatus: data['loan_status'],
      otherUserInfo: data['other_user_info'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'loan_status': loanStatus,
      'other_user_info': otherUserInfo,
    };
  }

  LoanAccount copyWith({
    String? userId,
    int? loanStatus,
    Map<String, dynamic>? otherUserInfo,
  }) {
    return LoanAccount(
      userId: userId ?? this.userId,
      loanStatus: loanStatus ?? this.loanStatus,
      otherUserInfo: otherUserInfo ?? this.otherUserInfo,
    );
  }

  @override
  String toString() {
    return 'LoanAccount{userId: $userId, loanStatus: $loanStatus, otherUserInfo: $otherUserInfo}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoanAccount &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          loanStatus == other.loanStatus &&
          otherUserInfo == other.otherUserInfo;

  @override
  int get hashCode => userId.hashCode ^ loanStatus.hashCode ^ otherUserInfo.hashCode;
}
