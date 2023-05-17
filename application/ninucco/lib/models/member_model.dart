class MemberModel {
  final String id, nickname, url;
  final int winCount, loseCount, point, elo;

  MemberModel({
    required this.id,
    required this.elo,
    required this.loseCount,
    required this.nickname,
    required this.point,
    required this.url,
    required this.winCount,
  });

  MemberModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nickname = json['nickname'],
        url = json['url'] ?? '',
        winCount = json['winCount'],
        loseCount = json['loseCount'],
        point = json['point'],
        elo = json['elo'];
}
