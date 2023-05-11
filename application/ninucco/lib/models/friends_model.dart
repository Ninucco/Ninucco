class FriendsModel {
  final List<Map<String, String>> friendsList;

  FriendsModel.fromJson(Map<String, dynamic> json)
      : friendsList = json['friendsList'];
}
