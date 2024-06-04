// class AddressAndReferralDayDataModel {
//   String? sId;
//   int? referDay;
//   String? address;

//   AddressAndReferralDayDataModel({this.sId, this.referDay, this.address});

//   AddressAndReferralDayDataModel.fromJson(Map<String, dynamic> json) {
//     // Use null-aware operators to handle null values
//     sId = json['_id'];
//     referDay = json['referDay'];
//     address = json['address'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     // Use null-coalescing operator to provide default values for null fields
//     data['_id'] = sId ?? '';
//     data['referDay'] = referDay ?? 0;
//     data['address'] = address ?? '';
//     return data;
//   }
// }
