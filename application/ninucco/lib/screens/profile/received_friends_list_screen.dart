import 'package:flutter/material.dart';
import 'package:ninucco/models/user_detail_model.dart';
import 'package:ninucco/providers/auth_provider.dart';
import 'package:ninucco/services/user_service.dart';
import 'package:provider/provider.dart';

class ReceivedFriendsListScreen extends StatefulWidget {
  final RouteSettings settings;
  const ReceivedFriendsListScreen({super.key, required this.settings});

  @override
  State<ReceivedFriendsListScreen> createState() =>
      _ReceivedFriendsListScreenState();
}

class _ReceivedFriendsListScreenState extends State<ReceivedFriendsListScreen> {
  List<Friend> _receivedFriendList = [];
  Future<void>? _initData;
  bool inited = false;

  Future<void> _initDatas(String id) async {
    final data = await UserService.getReceivedFriends(id);
    setState(() {
      _receivedFriendList = data;
    });
  }

  Future<void> _refreshData(String id) async {
    final data = await UserService.getReceivedFriends(id);
    setState(() {
      _receivedFriendList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    var me = Provider.of<AuthProvider>(context).member;
    var vw = MediaQuery.of(context).size.width;
    if (inited == false) {
      _initData = _initDatas(me!.id);
      inited = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("받은 친구요청"),
      ),
      body: FutureBuilder(
          future: _initData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              return const Text("Loding...");
            }
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg/bg2.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: RefreshIndicator(
                onRefresh: () => _refreshData(me!.id),
                child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  itemCount: _receivedFriendList.length,
                  itemBuilder: (context, index) {
                    var friendData = _receivedFriendList[index];
                    return Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(2, 2),
                            blurRadius: 8,
                          )
                        ],
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 12),
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    "/Profile",
                                    arguments: friendData.friendId,
                                  );
                                },
                                child: Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                  child: Image.network(friendData.profileImage),
                                ),
                              ),
                              const SizedBox(width: 8),
                              SizedBox(
                                width: vw - 240,
                                child: Text(
                                  "${friendData.nickname}님이 친구신청 하였습니다",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 6),
                          SizedBox(
                            width: 138,
                            child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        var tmpList = _receivedFriendList
                                            .where((i) =>
                                                i.friendId !=
                                                friendData.friendId)
                                            .toList();
                                        _receivedFriendList = tmpList;
                                      });

                                      UserService.allowFriend(
                                        friendId: friendData.friendId,
                                        myId: me!.id,
                                      );
                                    },
                                    child: const Text(
                                      "확인",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        var tmpList = _receivedFriendList
                                            .where((i) =>
                                                i.friendId !=
                                                friendData.friendId)
                                            .toList();
                                        _receivedFriendList = tmpList;
                                      });

                                      UserService.deleteFriend(
                                        friendId: friendData.friendId,
                                        myId: me!.id,
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey,
                                    ),
                                    child: const Text("삭제"),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          }),
    );
  }
}
