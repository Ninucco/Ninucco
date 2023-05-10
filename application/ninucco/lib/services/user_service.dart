import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ninucco/models/user_detail_model.dart';
import 'package:ninucco/models/user_model.dart';

class UserService {
  static Future<UserDetailData> getUserDetailById() async {
    const String baseUrl = "http://70.12.246.242:4000";
    final url = Uri.parse('$baseUrl/testuser');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final userDetail = jsonDecode(response.body);

      return UserDetailData.fromJson(userDetail);
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
}
