import 'package:flutter/material.dart' show immutable;

@immutable
class MoreDetails {
  final String numbersDetail;
  final String idType;
  final String state;
  final String issuedDate;

  const MoreDetails({
    required this.numbersDetail,
    required this.idType,
    required this.state,
    required this.issuedDate,
  });

  factory MoreDetails.fromJson(Map<String, dynamic> json) {
    return MoreDetails(
      numbersDetail: json['numbersDetail'] as String,
      idType: json['idType'] as String,
      state: json['state'] as String,
      issuedDate: json['issuedDate'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'numbersDetail': numbersDetail,
      'status': idType,
      'state': state,
      'issuedDate': issuedDate,
    };
  }

  MoreDetails copyWith({
    String? numbersDetail,
    String? idType,
    String? state,
    String? issuedDate,
  }) {
    return MoreDetails(
      numbersDetail: numbersDetail ?? this.numbersDetail,
      idType: idType ?? this.idType,
      state: state ?? this.state,
      issuedDate: issuedDate ?? this.issuedDate,
    );
  }

  @override
  String toString() {
    return 'MoreDetails{numbersDetail: $numbersDetail, status: $idType, state: $state, issuedDate: $issuedDate}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MoreDetails &&
        other.numbersDetail == numbersDetail &&
        other.idType == idType &&
        other.state == state &&
        other.issuedDate == issuedDate;
  }

  @override
  int get hashCode {
    return numbersDetail.hashCode ^
        idType.hashCode ^
        state.hashCode ^
        issuedDate.hashCode;
  }
}
