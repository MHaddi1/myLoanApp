import 'package:flutter/material.dart' show immutable;

@immutable
class EnrollUser {
  final String fname;
  final String lname;
  final String? middleName;
  final String dob;

  const EnrollUser({
    required this.fname,
    required this.lname,
    required this.dob,
    this.middleName,
  });

  factory EnrollUser.fromJson(Map<String, dynamic> json) {
    return EnrollUser(
      fname: json['fname'] as String,
      lname: json['lname'] as String,
      middleName: json['middleName'] as String?,
      dob: json['dob'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fname': fname,
      'lname': lname,
      'middleName': middleName,
      'dob': dob,
    };
  }

  EnrollUser copyWith({
    String? fname,
    String? lname,
    String? middleName,
    String? dob,
  }) {
    return EnrollUser(
      fname: fname ?? this.fname,
      lname: lname ?? this.lname,
      middleName: middleName ?? this.middleName,
      dob: dob ?? this.dob,
    );
  }

  @override
  String toString() {
    return 'EnrollUser{fname: $fname, lname: $lname, middleName: $middleName, dob: $dob}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EnrollUser &&
        other.fname == fname &&
        other.lname == lname &&
        other.middleName == middleName &&
        other.dob == dob;
  }

  @override
  int get hashCode {
    return fname.hashCode ^ lname.hashCode ^ middleName.hashCode ^ dob.hashCode;
  }
}
