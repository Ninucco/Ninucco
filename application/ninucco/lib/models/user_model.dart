class UserModel {
  final String nickname, profileImage, id;
  int winCount, loseCount, point, elo;

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        nickname = json['nickname'],
        profileImage = json['url'],
        winCount = json['winCount'],
        loseCount = json['loseCount'],
        point = json['point'],
        elo = json['elo'];
}
