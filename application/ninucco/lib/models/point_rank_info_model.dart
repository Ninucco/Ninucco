class PointRankInfoModel {
  final String profileImage, nickname, memberId;
  int winCount;

  PointRankInfoModel.fromJson(Map<String, dynamic> json)
      : profileImage = json['profileImage'],
        nickname = json['nickname'],
        winCount = json['point'],
        memberId = json['memberId'];
}
