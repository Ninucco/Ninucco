import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ninucco/models/user_detail_model.dart';
import 'package:ninucco/models/user_model.dart';

class UserService {
  static Future<UserDetailData> getUserDetailById(String userName) async {
    const String baseUrl = "https://k8a605.p.ssafy.io/api/member";
    final url = Uri.parse('$baseUrl/$userName');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final userDetail = jsonDecode(response.body);

      return UserDetailData.fromJson(userDetail['data']);
    }
    throw Error();
  }

  static Future<List<UserModel>> searchUserByNickname(String keyword) async {
    const String baseUrl = "https://k8a605.p.ssafy.io/api/member/search";
    List<UserModel> userList = [];
    final url = Uri.parse('$baseUrl/$keyword');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final memberList = jsonDecode(response.body)["data"]['memberList'];

      for (var member in memberList) {
        final instance = UserModel.fromJson(member);
        userList.add(instance);
      }
      return userList;
    }
    throw Error();
  }

  static Future<bool> existNickName(String nickname) async {
    final url = Uri.parse(
        "https://k8a605.p.ssafy.io/api/member/regist/nickname/?nickname=$nickname");
    final response = await http.get(url);

    return jsonDecode(response.body)['data']['validate'];
  }

  static void updateProfile({
    required String memberId,
    required String nickname,
    required String profileUrl,
  }) async {
    // 닉네임 변경
    final url = Uri.parse("https://k8a605.p.ssafy.io/api/member/nickname");
    Map data = {"id": memberId, "nickname": nickname};
    var body = json.encode(data);
    http.patch(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    // 프로필 이미지 변경
    final imageUrl =
        Uri.parse("https://k8a605.p.ssafy.io/api/member/photo/url");
    final request = http.MultipartRequest("PATCH", imageUrl);
    request.fields["memberId"] = memberId;
    request.fields["url"] = profileUrl;
    request.send();
  }

  static Future<String> checkFriend({
    required String friendId,
    required String myId,
  }) async {
    final url = Uri.parse(
        "https://k8a605.p.ssafy.io/api/member/friend/check?friendId=$friendId&myId=$myId");
    final response = await http.get(url);
    return jsonDecode(response.body)['data']['status'];
  }

  static void requestFriend({
    required String friendId,
    required String myId,
  }) async {
    final url = Uri.parse("https://k8a605.p.ssafy.io/api/member/friend");

    Map data = {"friendId": friendId, "myId": myId};
    var body = json.encode(data);
    http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );
  }

  static Future<List<Friend>> getReceivedFriends(String id) async {
    final url = Uri.parse(
        "https://k8a605.p.ssafy.io/api/member/received-friend-list?memberId=$id");

    final response = await http.get(url);
    var list = jsonDecode(response.body)['data']['friendList'] as List;
    List<Friend> friendList = list.map((i) => Friend.fromJson(i)).toList();
    return friendList;
  }

  static Future<List<Friend>> getFriends(String id) async {
    final url = Uri.parse(
        "https://k8a605.p.ssafy.io/api/member/friend-list?memberId=$id&status=FRIEND");

    final response = await http.get(url);
    var list = jsonDecode(response.body)['data']['friendList'] as List;
    List<Friend> friendList = list.map((i) => Friend.fromJson(i)).toList();
    return friendList;
  }

  static void allowFriend({
    required String friendId,
    required String myId,
  }) {
    final url = Uri.parse("https://k8a605.p.ssafy.io/api/member/friend/allow");
    Map data = {"friendId": friendId, "myId": myId};
    var body = json.encode(data);
    http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );
  }

  static void deleteFriend({
    required String friendId,
    required String myId,
  }) {
    final url = Uri.parse(
        "https://k8a605.p.ssafy.io/api/member/friend/delete?friendId=$friendId&myId=$myId");
    http.delete(url);
  }
}
