class BattleCommentInfoModel {
  final String profileImage, nickname, content, id;
  final List<dynamic> createdAt;

  BattleCommentInfoModel({
    required this.content,
    required this.profileImage,
    required this.id,
    required this.nickname,
    required this.createdAt,
  });

  BattleCommentInfoModel.fromJson(Map<String, dynamic> json)
      : id = json["memberId"],
        profileImage = json['profileImage'],
        nickname = json['nickname'],
        content = json['content'],
        createdAt = json['createdAt'];
}
