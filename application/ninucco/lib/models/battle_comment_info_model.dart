class BattleCommentInfoModel {
  final String profileImage, nickname, content;
  final int id;

  BattleCommentInfoModel.fromJson(Map<String, dynamic> json)
      : id = json["commentId"],
        profileImage = json['profileImage'],
        nickname = json['nickname'],
        content = json['content'];
}
