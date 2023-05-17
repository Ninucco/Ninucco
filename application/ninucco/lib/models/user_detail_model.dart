import 'package:ninucco/models/user_model.dart';
import 'package:ninucco/screens/home/scan_result.dart';

class Battle {
  final int battleId;
  final String title;
  final String applicantName;
  final String applicantUrl;
  final String opponentName;

  final String applicantId;
  final String opponentId;
  final String opponentUrl;
  final String result;

  final double applicantOdds;
  final double opponentOdds;

  Battle({
    required this.battleId,
    required this.result,
    required this.title,
    required this.applicantName,
    required this.opponentName,
    required this.applicantUrl,
    required this.applicantId,
    required this.opponentId,
    required this.opponentUrl,
    required this.applicantOdds,
    required this.opponentOdds,
  });

  factory Battle.fromJson(Map<String, dynamic> json) {
    return Battle(
      battleId: json['battleId'],
      applicantName: json['applicantName'],
      opponentName: json['opponentName'],
      title: json['title'],
      applicantUrl: json['applicantUrl'],
      applicantId: json['applicantId'] ?? '',
      opponentId: json['opponentId'] ?? '',
      opponentUrl: json['opponentUrl'] ?? '',
      applicantOdds: json['applicantOdds'] ?? 2.0,
      opponentOdds: json['opponentOdds'] ?? 2.0,
      result: json['result'] ?? "null",
    );
  }
}

class UserDetailData {
  final UserModel user;
  final List<dynamic> friendList;
  final List<dynamic> itemList;
  final List<ResultData> scanResultList;
  final List<Battle> receivedBattles;
  final List<Battle> curBattleList;
  final List<Battle> prevBattleList;

  UserDetailData({
    required this.user,
    required this.friendList,
    required this.itemList,
    required this.curBattleList,
    required this.prevBattleList,
    required this.scanResultList,
    required this.receivedBattles,
  });

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

    var tempCurBattleList = json['curBattles'] as List;
    List<Battle> curBattleList =
        tempCurBattleList.map((i) => Battle.fromJson(i)).toList();

    var tempPrevBattleList = json['prevBattles'] as List;
    List<Battle> prevBattleList =
        tempPrevBattleList.map((i) => Battle.fromJson(i)).toList();

    return UserDetailData(
      user: UserModel.fromJson(json['user']),
      friendList: friendList,
      scanResultList: scanResultList,
      receivedBattles: receivedBattles,
      curBattleList: curBattleList,
      prevBattleList: prevBattleList,
      itemList: [],
    );
  }
}

class Friend {
  final String friendId;
  final String profileImage;
  final String nickname;
  final String status;

  Friend({
    required this.friendId,
    required this.profileImage,
    required this.nickname,
    required this.status,
  });

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      friendId: json['friendId'],
      nickname: json['nickname'],
      profileImage: json['profileImage'],
      status: json['status'],
    );
  }
}
