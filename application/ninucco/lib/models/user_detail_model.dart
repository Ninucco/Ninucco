import 'package:ninucco/models/user_model.dart';
import 'package:ninucco/screens/home/scan_result.dart';

class Battle {
  final int battleId;
  final String applicantName;
  final String opponentName;
  final String title;
  final String applicantUrl;

  Battle({
    required this.battleId,
    required this.applicantName,
    required this.opponentName,
    required this.title,
    required this.applicantUrl,
  });

  factory Battle.fromJson(Map<String, dynamic> json) {
    return Battle(
      battleId: json['battleId'],
      applicantName: json['applicantName'],
      opponentName: json['opponentName'],
      title: json['title'],
      applicantUrl: json['applicantUrl'],
    );
  }
}

class UserDetailData {
  final UserModel user;
  final List<dynamic> friendList;
  final List<dynamic> itemList;
  final List<dynamic> curBattleList;
  final List<dynamic> prevBattleList;
  final List<ResultData> scanResultList;
  final List<Battle> receivedBattles;

  UserDetailData(
      {required this.user,
      required this.friendList,
      required this.itemList,
      required this.curBattleList,
      required this.prevBattleList,
      required this.scanResultList,
      required this.receivedBattles});

  factory UserDetailData.fromJson(Map<String, dynamic> json) {
    var list = json['scanResults'] as List;
    List<ResultData> scanResultList =
        list.map((i) => ResultData.fromJson(i)).toList();

    var tempFriendList = json['friendList'] ?? [];
    List<dynamic> friendList =
        tempFriendList?.map((i) => UserModel.fromJson(i)).toList();

    var tempReceivedBattles = json['receivedBattles'] as List;
    List<Battle> receivedBattles =
        tempReceivedBattles.map((i) => Battle.fromJson(i)).toList();

    return UserDetailData(
      user: UserModel.fromJson(json['user']),
      friendList: friendList,
      scanResultList: scanResultList,
      receivedBattles: receivedBattles,
      curBattleList: [],
      itemList: [],
      prevBattleList: [],
    );
  }
}
