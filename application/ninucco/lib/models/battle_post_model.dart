import 'dart:io';

class BattlePostModel {
  File memberAImage = File('');
  String question = "", memberAId = "", memberBId = "";

  BattlePostModel(
    this.memberAImage,
    this.memberAId,
    this.memberBId,
    this.question,
  );
}
