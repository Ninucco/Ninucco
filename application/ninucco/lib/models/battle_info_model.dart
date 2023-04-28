class BattleInfoModel {
  final int memberAId, memberBId, battleId;
  final double ratioA, ratioB;
  final String memberAImage,
      memberBImage,
      question,
      memberANickname,
      memberBNickname;
  BattleInfoModel.fromJson(Map<String, dynamic> json)
      : battleId = json["id"],
        memberAImage = json['image'],
        memberBImage = json['image'],
        ratioA = 3.0,
        ratioB = 1.3,
        memberAId = json['id'],
        memberBId = json['id'],
        question = json['firstName'] + " " + json['lastName'],
        memberANickname = json['username'],
        memberBNickname = json['username'];
}
