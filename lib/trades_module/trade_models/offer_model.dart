class OfferModel {
  String? sId;
  String? offerImage;
  String? createdAt;
  String? updatedAt;

  OfferModel({this.sId, this.offerImage, this.createdAt, this.updatedAt});

  OfferModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    offerImage = json['offerImage'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['offerImage'] = offerImage;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
