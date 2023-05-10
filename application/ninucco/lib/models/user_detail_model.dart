import 'package:ninucco/models/user_model.dart';
import 'package:ninucco/screens/home/scan_result.dart';

class UserDetailData {
  final UserModel user;
  final List<dynamic> friendList;
  final List<dynamic> itemList;
  final List<dynamic> curBattleList;
  final List<dynamic> prevBattleList;
  final List<ResultData> scanResultList;

  UserDetailData({
    required this.user,
    required this.friendList,
    required this.itemList,
    required this.curBattleList,
    required this.prevBattleList,
    required this.scanResultList,
  });

  factory UserDetailData.fromJson(Map<String, dynamic> json) {
    var list = json['scanResults'] as List;
    List<ResultData> scanResultList =
        list.map((i) => ResultData.fromJson(i)).toList();
    var tempFriendList = json['friendList'] as List;
    List<UserModel> friendList =
        tempFriendList.map((i) => UserModel.fromJson(i)).toList();

    return UserDetailData(
      user: UserModel.fromJson(json['user']),
      friendList: friendList,
      scanResultList: scanResultList,
      curBattleList: [],
      itemList: [],
      prevBattleList: [],
    );
  }
}
