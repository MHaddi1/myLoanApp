import 'package:flutter/material.dart' show immutable;
import 'package:main_loan_app/models/enroll_living_detail_model.dart';
import 'package:main_loan_app/models/enrolldetails_model.dart';
import 'package:main_loan_app/models/enrolluser_model.dart';
import 'package:main_loan_app/models/moredetail_model.dart';

@immutable
class Enroll {
  final EnrollUser user;
  final EnrollDetails enrollDetails;
  final EnrollLiving enrollLiving;
  final MoreDetails moreDetails;

  const Enroll({
    required this.user,
    required this.enrollDetails,
    required this.enrollLiving,
    required this.moreDetails,
  });

  factory Enroll.fromJson(Map<String, dynamic> json) {
    return Enroll(
      user: EnrollUser.fromJson(json['user']),
      enrollDetails: EnrollDetails.fromJson(json['enrollDetails']),
      enrollLiving: EnrollLiving.fromJson(json['enrollLiving']),
      moreDetails: MoreDetails.fromJson(json['moreDetails']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'enrollDetails': enrollDetails.toJson(),
      'enrollLiving': enrollLiving.toJson(),
      'moreDetails': moreDetails.toJson(),
    };
  }

  Enroll copyWith({
    EnrollUser? user,
    EnrollDetails? enrollDetails,
    EnrollLiving? enrollLiving,
    MoreDetails? moreDetails,
  }) {
    return Enroll(
      user: user ?? this.user,
      enrollDetails: enrollDetails ?? this.enrollDetails,
      enrollLiving: enrollLiving ?? this.enrollLiving,
      moreDetails: moreDetails ?? this.moreDetails,
    );
  }

  @override
  String toString() {
    return 'Enroll{user: $user, enrollDetails: $enrollDetails, enrollLiving: $enrollLiving, moreDetails: $moreDetails}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Enroll &&
        other.user == user &&
        other.enrollDetails == enrollDetails &&
        other.enrollLiving == enrollLiving &&
        other.moreDetails == moreDetails;
  }

  @override
  int get hashCode {
    return user.hashCode ^
        enrollDetails.hashCode ^
        enrollLiving.hashCode ^
        moreDetails.hashCode;
  }
}
