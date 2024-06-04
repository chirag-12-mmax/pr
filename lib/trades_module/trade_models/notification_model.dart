class NotificationModel {
  String? sId;
  String? image;
  String? title;
  String? subTitle;
  String? notificationTime;
  String? createdAt;
  String? updatedAt;
  int? iV;

  NotificationModel(
      {this.sId,
      this.image,
      this.title,
      this.subTitle,
      this.notificationTime,
      this.createdAt,
      this.updatedAt,
      this.iV});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    image = json['image'];
    notificationTime = json['notificationTime'];
    title = json['title'];
    subTitle = json['subTitle'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['image'] = image;
    data['title'] = title;
    data['subTitle'] = subTitle;
    data['notificationTime'] = notificationTime;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
