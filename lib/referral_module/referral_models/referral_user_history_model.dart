// ignore_for_file: unnecessary_getters_setters

class ReferralUserHistoryModel {
  String? _mobileNo;
  String? _name;
  String? _email;
  String? _profileImage;
  String? _createdAt;

  ReferralUserHistoryModel(
      {String? mobileNo,
      String? name,
      String? email,
      String? profileImage,
      String? createdAt}) {
    if (mobileNo != null) {
      _mobileNo = mobileNo;
    }
    if (profileImage != null) {
      _profileImage = profileImage;
    }
    if (name != null) {
      _name = name;
    }
    if (email != null) {
      _email = email;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
  }

  String? get mobileNo => _mobileNo;
  set mobileNo(String? mobileNo) => _mobileNo = mobileNo;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get profileImage => _profileImage;
  set profileImage(String? profileImage) => _profileImage = profileImage;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;

  ReferralUserHistoryModel.fromJson(Map<String, dynamic> json) {
    _mobileNo = json['mobileNo'];
    _profileImage = json['profileImage'];
    _name = json['name'];
    _email = json['email'];
    _createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mobileNo'] = _mobileNo;
    data['profileImage'] = _profileImage;
    data['name'] = _name;
    data['email'] = _email;
    data['createdAt'] = _createdAt;
    return data;
  }
}
