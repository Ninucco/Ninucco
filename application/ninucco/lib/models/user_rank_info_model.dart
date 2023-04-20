class UserRankInfoModel {
  final String profileImage, nickname, topSimilarity;
  int rankIdx;

  UserRankInfoModel.fromJson(Map<String, dynamic> json)
      : profileImage = json['profileImage'],
        nickname = json['nickname'],
        topSimilarity = json['topSimilarity'],
        rankIdx = json['rankIdx'];
}
