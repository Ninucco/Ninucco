class UserRankInfoModel {
  final String profileImage, nickname, memberId;
  int winCount;

  UserRankInfoModel.fromJson(Map<String, dynamic> json)
      : profileImage = json['profileImage'],
        nickname = json['nickname'],
        winCount = json['winCount'],
        memberId = json['memberId'];
}
