class EloRankInfoModel {
  final String profileImage, nickname, memberId;
  int winCount;

  EloRankInfoModel.fromJson(Map<String, dynamic> json)
      : profileImage = json['profileImage'],
        nickname = json['nickname'],
        winCount = json['elo'],
        memberId = json['memberId'];
}
