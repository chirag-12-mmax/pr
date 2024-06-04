class PaymentHistoryModel {
  String? sId;
  String? planId;
  String? userId;
  int? price;
  int? paymentStatus;
  int? isDelete;
  String? createdAt;
  String? updatedAt;

  int? iV;

  PaymentHistoryModel(
      {this.sId,
      this.planId,
      this.userId,
      this.price,
      this.paymentStatus,
      this.isDelete,
      this.createdAt,
      this.updatedAt,
      this.iV});

  PaymentHistoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    planId = json['planId'];
    userId = json['userId'];
    price = json['price'];
    paymentStatus = json['paymentStatus'];
    isDelete = json['isDelete'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['planId'] = planId;
    data['userId'] = userId;
    data['price'] = price;
    data['paymentStatus'] = paymentStatus;
    data['isDelete'] = isDelete;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
