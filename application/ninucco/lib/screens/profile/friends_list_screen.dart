import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ninucco/models/user_detail_model.dart';
import 'package:ninucco/services/user_service.dart';

class FriendsListScreen extends StatefulWidget {
  final RouteSettings settings;
  const FriendsListScreen({super.key, required this.settings});

  @override
  State<FriendsListScreen> createState() => _FriendsListScreenState();
}

class _FriendsListScreenState extends State<FriendsListScreen> {
  List<Friend> _receivedFriendList = [];
  Future<void>? _initData;
  bool inited = false;

  Future<void> _initDatas() async {
    var memberId = widget.settings.arguments as String;
    final data = await UserService.getFriends(memberId);
    setState(() {
      _receivedFriendList = data;
    });
  }

  Future<void> _refreshData() async {
    var memberId = widget.settings.arguments as String;
    final data = await UserService.getFriends(memberId);
    setState(() {
      _receivedFriendList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    var vw = MediaQuery.of(context).size.width;
    if (inited == false) {
      _initData = _initDatas();
      inited = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("친구목록"),
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
                onRefresh: () => _refreshData(),
                child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  itemCount: _receivedFriendList.length,
                  itemBuilder: (context, index) {
                    var friendData = _receivedFriendList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/Profile",
                            arguments: friendData.friendId);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(2, 2),
                                blurRadius: 8,
                              )
                            ]),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 12),
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: CachedNetworkImage(
                                  imageUrl: friendData.profileImage),
                            ),
                            const SizedBox(width: 8),
                            SizedBox(
                              width: vw - 96,
                              child: Text(
                                friendData.nickname,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
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
