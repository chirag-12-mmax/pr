class TipsDetailsModel {
  FindTips? findTips;
  List<FindAllTips>? findAllTips;

  TipsDetailsModel({this.findTips, this.findAllTips});

  TipsDetailsModel.fromJson(Map<String, dynamic> json) {
    findTips = json['findTips'] != null
        ? FindTips.fromJson(json['findTips'])
        : null;
    if (json['findAllTips'] != null) {
      findAllTips = <FindAllTips>[];
      json['findAllTips'].forEach((v) {
        findAllTips!.add(FindAllTips.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (findTips != null) {
      data['findTips'] = findTips!.toJson();
    }
    if (findAllTips != null) {
      data['findAllTips'] = findAllTips!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FindTips {
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

  FindTips(
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

  FindTips.fromJson(Map<String, dynamic> json) {
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

class FindAllTips {
  String? sId;
  String? name;
  int? lastPrice;
  String? createdAt;

  FindAllTips({this.sId, this.name, this.lastPrice, this.createdAt});

  FindAllTips.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    lastPrice = json['lastPrice'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['lastPrice'] = lastPrice;
    data['createdAt'] = createdAt;
    return data;
  }
}