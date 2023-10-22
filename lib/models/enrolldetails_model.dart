import 'package:flutter/material.dart' show immutable;

@immutable
class EnrollDetails {
  final String email;
  final String phoneType;
  final String phone;
  final int zipcode;
  final String address;
  final String? optionalAddress;

  const EnrollDetails({
    required this.email,
    required this.phoneType,
    required this.phone,
    required this.zipcode,
    required this.address,
    this.optionalAddress,
  });

  factory EnrollDetails.fromJson(Map<String, dynamic> json) {
    print("Inside EnrollDetails");
    return EnrollDetails(
      email: json['email'] as String,
      phoneType: json['phoneType'] as String,
      phone: json['phone'] as String,
      zipcode: json['zipcode'] as int,
      address: json['address'] as String,
      optionalAddress: json['optionalAddress'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phoneType': phoneType,
      'phone': phone,
      'zipcode': zipcode,
      'address': address,
      'optionalAddress': optionalAddress,
    };
  }

  EnrollDetails copyWith({
    String? email,
    String? phoneType,
    String? phone,
    int? zipcode,
    String? address,
    String? optionalAddress,
  }) {
    return EnrollDetails(
      email: email ?? this.email,
      phoneType: phoneType ?? this.phoneType,
      phone: phone ?? this.phone,
      zipcode: zipcode ?? this.zipcode,
      address: address ?? this.address,
      optionalAddress: optionalAddress ?? this.optionalAddress,
    );
  }

  @override
  String toString() {
    return 'EnrollDetails{email: $email, status: $phoneType, phone: $phone, zipcode: $zipcode, address: $address, optionalAddress: $optionalAddress}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EnrollDetails &&
        other.email == email &&
        other.phoneType == phoneType &&
        other.phone == phone &&
        other.zipcode == zipcode &&
        other.address == address &&
        other.optionalAddress == optionalAddress;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        phoneType.hashCode ^
        phone.hashCode ^
        zipcode.hashCode ^
        address.hashCode ^
        optionalAddress.hashCode;
  }
}
