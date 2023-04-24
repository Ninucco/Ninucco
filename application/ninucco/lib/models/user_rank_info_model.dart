class UserRankInfoModel {
  final String profileImage, nickname, topSimilarity;
  int id;

  UserRankInfoModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        profileImage = json['image'],
        nickname = json['username'],
        topSimilarity =
            json['firstName'] + " " + json['lastName']; // 최고 닮은꼴로 수정 예정
}
