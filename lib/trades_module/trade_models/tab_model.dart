class TabModel {
  String? sId;
  String? name;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? iV;

  TabModel(
      {this.sId,
      this.name,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.iV});

  TabModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
