class BattleCommentInfoModel {
  final String profileImage, nickname, content;
  final int id;

  BattleCommentInfoModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        profileImage = json['image'],
        nickname = json['username'],
        content = json['firstName'] +
            " " +
            json['lastName'] +
            " 왔다감ㅋㅋ"; // 실 댓글로 수정 예정
}
