class BattleInfoModel {
  int memberAId = 0, memberBId = 0, battleId = 0;
  double ratioA = 0, ratioB = 0;
  String memberAImage = "",
      memberBImage = "",
      question = "",
      memberANickname = "",
      memberBNickname = "";

  BattleInfoModel(
      this.battleId,
      this.memberAId,
      this.memberBId,
      this.memberAImage,
      this.memberANickname,
      this.memberBImage,
      this.memberBNickname,
      this.question,
      this.ratioA,
      this.ratioB);

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
