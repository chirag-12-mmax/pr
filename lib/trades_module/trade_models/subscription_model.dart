class SubscriptionModel {
  String? sId;
  int? months;
  int? amount;
  int? discountAmount;
  int? discount;
  int? status;

  SubscriptionModel(
      {this.sId,
      this.months,
      this.amount,
      this.discountAmount,
      this.discount,
      this.status});

  SubscriptionModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    months = json['months'];
    amount = json['amount'];
    discountAmount = json['discountAmount'];
    discount = json['discount'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['months'] = months;
    data['amount'] = amount;
    data['discountAmount'] = discountAmount;
    data['discount'] = discount;
    data['status'] = status;
    return data;
  }
}
