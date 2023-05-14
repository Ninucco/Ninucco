class BattleBettingRequestModel {
  String betSide, memberId;
  int battleId, betMoney;

  BattleBettingRequestModel(
    this.battleId,
    this.betMoney,
    this.betSide,
    this.memberId,
  );
}
