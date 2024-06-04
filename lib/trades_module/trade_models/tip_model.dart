class TipsModel {
  String? date;
  String? sId;
  String? name;
  int? buyPrice;
  int? stopLimit;
  int? targetPrice;
  int? lastPrice;
  int? term;
  String? status;
  String? createdAt;
  String? updatedAt;

  TipsModel(
      {this.date,
      this.sId,
      this.name,
      this.buyPrice,
      this.stopLimit,
      this.targetPrice,
      this.lastPrice,
      this.term,
      this.status,
      this.createdAt,
      this.updatedAt});

  TipsModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    sId = json['_id'];
    name = json['name'];
    buyPrice = json['buyPrice'];
    stopLimit = json['stopLimit'];
    targetPrice = json['targetPrice'];
    lastPrice = json['lastPrice'];
    term = json['term'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['_id'] = sId;
    data['name'] = name;
    data['buyPrice'] = buyPrice;
    data['stopLimit'] = stopLimit;
    data['targetPrice'] = targetPrice;
    data['lastPrice'] = lastPrice;
    data['term'] = term;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
