import 'dart:io';

class BattleCreateModel {
  String memberAId = "";
  File memberAImage = File('');
  String question = "", memberANickname = "";

  BattleCreateModel(
      this.memberAId, this.memberAImage, this.memberANickname, this.question);
}
