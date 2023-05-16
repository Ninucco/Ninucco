class BattleCommentInfoModel {
  final String profileImage, nickname, content;
  final int id;
  BattleCommentInfoModel({
    required this.content,
    required this.profileImage,
    required this.id,
    required this.nickname,
  });

  BattleCommentInfoModel.fromJson(Map<String, dynamic> json)
      : id = json["commentId"],
        profileImage = json['profileImage'],
        nickname = json['nickname'],
        content = json['content'];
}
