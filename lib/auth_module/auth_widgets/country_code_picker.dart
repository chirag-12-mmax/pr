// import 'dart:convert';

// import 'package:country_picker/country_picker.dart';
// import 'package:flutter/material.dart';

// void pickCountryCode({
//   required BuildContext context,
//   required void Function(PickedCountryCode) onSelect,
// }) =>
//     showCountryPicker(
//       context: context,
//       showPhoneCode:
//           true, // optional. Shows phone code before the country name.
//       onSelect: (country){},
//     );

// class PickedCountryCode {
//   final String phoneCode;
//   final String flagEmoji;
//   PickedCountryCode({
//     required this.phoneCode,
//     required this.flagEmoji,
//   });
//   PickedCountryCode copyWith({String? phoneCode, String? flagEmoji}) {
//     return PickedCountryCode(
//       phoneCode: phoneCode ?? this.phoneCode,
//       flagEmoji: flagEmoji ?? this.flagEmoji,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'phoneCode': phoneCode,
//       'flagEmoji': flagEmoji,
//     };
//   }

//   factory PickedCountryCode.fromMap(Map<String, dynamic> map) {
//     return PickedCountryCode(
//       phoneCode: map['phoneCode'] as String,
//       flagEmoji: map['flagEmoji'] as String,
//     );
//   }
//   String toJson() => json.encode(toMap());
//   factory PickedCountryCode.fromJson(String source) => PickedCountryCode.fromMap(
//         json.decode(source) as Map<String, dynamic>,
//       );

//   @override
//   String toString() =>
//       'PickCountryCode(phoneCode:$phoneCode,flagEmoji:$flagEmoji)';
//   @override
//   bool operator ==(covariant PickedCountryCode other) {
//     if (identical(this, other)) return true;
//     return other.phoneCode == phoneCode && other.flagEmoji == flagEmoji;
//   }

//   @override
//   int get hashCode => phoneCode.hashCode ^ flagEmoji.hashCode;
// }
