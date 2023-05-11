class BattlePostResponseModel {
  final String memberANickname, memberBNickname, question, memberAImage;
  final bool validate;
  final int id;

  BattlePostResponseModel.fromJson(Map<String, dynamic> json)
      : memberANickname = json['applicantName'],
        memberBNickname = json['opponentName'],
        id = json["battleId"],
        question = json['title'],
        memberAImage = json['applicantUrl'],
        validate = json['validate'];
}
