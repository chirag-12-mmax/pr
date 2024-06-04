class FeedBackModel {
  String? sId;
  String? image;
  String? content;
  int? likeCount;
  String? createdAt;
  UserData? userData;
  int? like;

  FeedBackModel(
      {this.sId,
      this.image,
      this.content,
      this.likeCount,
      this.createdAt,
      this.userData,
      this.like});

  FeedBackModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    image = json['image'];
    content = json['content'];
    likeCount = json['likeCount'];
    createdAt = json['createdAt'];
    userData =
        json['userData'] != null ? UserData.fromJson(json['userData']) : null;
    like = json['like'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['image'] = image;
    data['content'] = content;
    data['likeCount'] = likeCount;
    data['createdAt'] = createdAt;
    if (userData != null) {
      data['userData'] = userData!.toJson();
    }
    data['like'] = like;
    return data;
  }
}

class UserData {
  String? name;
  String? profileImage;
  int? autoCut;
  List<dynamic>? blockFeed;

  UserData({this.name, this.profileImage, this.blockFeed, this.autoCut});

  UserData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    autoCut = json['autoCut'];
    profileImage = json['profileImage'];
    blockFeed = json['blockFeed'] ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['autoCut'] = autoCut;
    data['profileImage'] = profileImage;
    data['blockFeed'] = blockFeed;
    return data;
  }
}
