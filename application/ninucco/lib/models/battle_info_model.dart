class BattleInfoModel {
  final int memberAId, memberBId, battleId;
  final double ratioA, ratioB;
  final String memberAImage,
      memberBImage,
      question,
      memberANickname,
      memberBNickname;
  BattleInfoModel.fromJson(Map<String, dynamic> json)
      : battleId = json["battleId"],
        memberAImage = json['applicantUrl'],
        memberBImage = json['opponentUrl'],
        ratioA = json['applicantOdds'],
        ratioB = json['opponentOdds'],
        memberAId = 1,
        memberBId = 1,
        question = json['title'],
        memberANickname = json['applicantName'],
        memberBNickname = json['opponentName'];
}
