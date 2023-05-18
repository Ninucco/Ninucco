class BattleCommentInfoModel {
  final String profileImage, nickname, content, id;

  BattleCommentInfoModel({
    required this.content,
    required this.profileImage,
    required this.id,
    required this.nickname,
  });

  BattleCommentInfoModel.fromJson(Map<String, dynamic> json)
      : id = json["memberId"],
        profileImage = json['profileImage'],
        nickname = json['nickname'],
        content = json['content'];
}
