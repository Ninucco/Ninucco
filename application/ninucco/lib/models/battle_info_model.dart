class BattleInfoModel {
  int battleId = 0;
  double ratioA = 0, ratioB = 0;
  String memberAImage = "",
      memberBImage = "",
      question = "",
      memberANickname = "",
      memberBNickname = "",
      memberAId = "",
      memberBId = "";

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
        ratioA = double.parse(json['applicantOdds'].toStringAsFixed(2)),
        ratioB = double.parse(json['opponentOdds'].toStringAsFixed(2)),
        memberAId = json["applicantId"],
        memberBId = json["opponentId"],
        question = json['title'],
        memberANickname = json['applicantName'],
        memberBNickname = json['opponentName'];
}
