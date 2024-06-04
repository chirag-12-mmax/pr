class UserModel {
  String? sId;
  String? mobileNo;
  String? name;
  String? email;
  String? countryCode;
  int? isActive;
  String? referralCode;
  String? userReferralCode;
  int? otp;
  int? autoCut;
  int? termsAgree;
  String? profileImage;
  List<dynamic>? referralUser;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? benefitsDays;
  int? referralDay;
  double? timeDifference;
  String? token;
  String? refreshToken;
  int? isSubscribe;

  int? isBenefits;

  String? fTPToken;
  String? isReferExpire;

  int? referralCount;

  UserModel(
      {this.sId,
      this.mobileNo,
      this.name,
      this.email,
      this.countryCode,
      this.isActive,
      this.autoCut,
      this.referralCode,
      this.userReferralCode,
      this.otp,
      this.profileImage,
      this.referralUser,
      this.isSubscribe,
      this.isBenefits,
      this.termsAgree,
      this.benefitsDays,
      this.referralDay,
      this.fTPToken,
      this.isReferExpire,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.token,
      this.timeDifference,
      this.refreshToken,
      this.referralCount});

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    mobileNo = json['mobileNo'];
    name = json['name'];
    email = json['email'];
    countryCode = json['countryCode'];
    isActive = json['isActive'];
    autoCut = json['autoCut'];
    referralCode = json['referralCode'];
    userReferralCode = json['userReferralCode'];
    otp = json['otp'];
    profileImage = json['profileImage'];
    if (json['referralUser'] != null) {
      referralUser = <dynamic>[];
      json['referralUser'].forEach((v) {
        referralUser!.add(v);
      });
    }
    isSubscribe = json['isSubscribe'];
    isBenefits = json['isBenefits'];
    termsAgree = json['termsAgree'];
    benefitsDays = json['benefitsDays'];
    referralDay = json['referralDay'];
    fTPToken = json['FTPToken'];
    isReferExpire = json['isReferExpire'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    token = json['token'];
    timeDifference = json['timeDifference'];
    refreshToken = json['refreshToken'];
    referralCount = json['referralCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['mobileNo'] = mobileNo;
    data['name'] = name;
    data['email'] = email;
    data['countryCode'] = countryCode;
    data['isActive'] = isActive;
    data['autoCut'] = autoCut;
    data['referralCode'] = referralCode;
    data['userReferralCode'] = userReferralCode;
    data['otp'] = otp;
    data['profileImage'] = profileImage;
    if (referralUser != null) {
      data['referralUser'] = referralUser!.map((v) => v.toJson()).toList();
    }
    data['isSubscribe'] = isSubscribe;
    data['isBenefits'] = isBenefits;
    data['termsAgree'] = termsAgree;
    data['benefitsDays'] = benefitsDays;
    data['referralDay'] = referralDay;
    data['FTPToken'] = fTPToken;
    data['isReferExpire'] = isReferExpire;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['token'] = token;
    data['timeDifference'] = timeDifference;
    data['refreshToken'] = refreshToken;
    data['referralCount'] = referralCount;
    return data;
  }
}
