import 'package:flutter/material.dart' show immutable;
import 'package:flutter/foundation.dart';

@immutable
class EnrollLiving {
  final String country;
  final String state;
  final String city;
  final String? ssn;
  final String? itin;
  final String jobT;
  final String livingPlace;

  const EnrollLiving({
    required this.country,
    required this.state,
    required this.city,
    this.ssn,
    this.itin,
    required this.jobT,
    required this.livingPlace,
  });

  factory EnrollLiving.fromJson(Map<String, dynamic> json) {
    return EnrollLiving(
      country: json['country'] as String,
      state: json['state'] as String,
      city: json['city'] as String,
      ssn: json['ssn'] as String?,
      itin: json['itin'] as String?,
      jobT: json['jobT'] as String,
      livingPlace: json['livingPlace'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    if (kDebugMode) {
      print("City is $city");
    }
    return {
      'country': country,
      'state': state,
      'city': city,
      'ssn': ssn,
      'itin': itin,
      'jobT': jobT,
      'livingPlace': livingPlace,
    };
  }

  EnrollLiving copyWith({
    String? country,
    String? state,
    String? city,
    String? ssn,
    String? itin,
    String? jobT,
    String? livingPlace,
  }) {
    return EnrollLiving(
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      ssn: ssn ?? this.ssn,
      itin: itin ?? this.itin,
      jobT: jobT ?? this.jobT,
      livingPlace: livingPlace ?? this.livingPlace,
    );
  }

  @override
  String toString() {
    return 'EnrollLiving{country: $country, state: $state, city: $city, ssn: $ssn, itin: $itin, jobT: $jobT, livingPlace: $livingPlace}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EnrollLiving &&
        other.country == country &&
        other.state == state &&
        other.city == city &&
        other.ssn == ssn &&
        other.itin == itin &&
        other.jobT == jobT &&
        other.livingPlace == livingPlace;
  }

  @override
  int get hashCode {
    return country.hashCode ^
        state.hashCode ^
        city.hashCode ^
        ssn.hashCode ^
        itin.hashCode ^
        jobT.hashCode ^
        livingPlace.hashCode;
  }
}
