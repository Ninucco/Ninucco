import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ninucco/models/user_detail_model.dart';
import 'package:ninucco/providers/auth_provider.dart';
import 'package:ninucco/screens/profile/my_profile.dart';
import 'package:ninucco/screens/profile/profile_battles_list.dart';
import 'package:ninucco/screens/profile/profile_scan_result.dart';
import 'package:ninucco/services/user_service.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  final RouteSettings settings;
  const ProfileScreen({super.key, required this.settings});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

/// Todo
/// [] settings에서 받아온 유저 데이터로 연결하기
/// [] settings에서 받아온 유저와 provider의 유저와 비교해서 본인인지 확인
/// [] 내가 아닌경우 친구신청
/// [] 나인 경우 can edit
///

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  final List<String> tabs = <String>['검사결과', '배틀이력', '아이템'];
  late TabController _tabController = TabController(length: 3, vsync: this);

  bool inited = false;
  late String userId;

  UserDetailData? _userDetailData;
  String _isFriend = "NONE";
  List<Friend> _friendList = [];

  Future<void>? _initUserDetail;

  @override
  void initState() {
    super.initState();
    userId = widget.settings.arguments as String;
    _tabController = TabController(length: 3, vsync: this);
  }

  Future<void> _initDatas(String id, String myId) async {
    final userDetailData = await UserService.getUserDetailById(id);
    final isFriend = await UserService.checkFriend(friendId: id, myId: myId);
    final friendsList = await UserService.getFriends(id);

    setState(() {
      _userDetailData = userDetailData;
      _isFriend = isFriend;
      _friendList = friendsList;
    });
  }

  Future<void> _refreshData(String id, String myId) async {
    final data = await UserService.getUserDetailById(id);
    final checkFriend = await UserService.checkFriend(friendId: id, myId: myId);
    final friendsList = await UserService.getFriends(id);

    setState(() {
      _userDetailData = data;
      _isFriend = checkFriend;
      _friendList = friendsList;
    });
  }

  void requestFriend() {
    setState(() {
      _isFriend = "WAITING";
    });
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    var me = authProvider.member;

    if (inited == false) {
      _initUserDetail = _initDatas(userId, me!.id);
      inited = true;
    }

    var myTabBar = TabBar(
      controller: _tabController,
      indicatorColor: Colors.teal,
      labelColor: Colors.teal,
      unselectedLabelColor: Colors.black54,
      isScrollable: true,
      tabs: tabs
          .map(
            (e) => SizedBox(
              width: MediaQuery.of(context).size.width / 4,
              child: Tab(
                text: e,
              ),
            ),
          )
          .toList(),
    );

    return DefaultTabController(
      length: tabs.length, // This is the number of tabs.
      child: SafeArea(
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) => [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: FutureBuilder(
                    future: _initUserDetail,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        return SliverPersistentHeader(
                          pinned: true,
                          delegate: HomeSliverAppBar(
                            expandedHeight: 450.0,
                            height: 108,
                            tabbar: myTabBar,
                            userData: null,
                            friendStatus: _isFriend,
                            requestFriend: requestFriend,
                            friendsCount: _friendList.length,
                          ),
                        );
                      }
                      return SliverPersistentHeader(
                        pinned: true,
                        delegate: HomeSliverAppBar(
                          expandedHeight: 450.0,
                          height: 108,
                          tabbar: myTabBar,
                          userData: _userDetailData,
                          friendStatus: _isFriend,
                          requestFriend: requestFriend,
                          friendsCount: _friendList.length,
                        ),
                      );
                    }),
              ),
            ],
            body: TabBarView(
                controller: _tabController,
                children: tabs
                    .map((name) => SafeArea(
                          top: false,
                          bottom: false,
                          child: FutureBuilder(
                            future: _initUserDetail,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                      ConnectionState.active ||
                                  _userDetailData == null) {
                                return const Text("LOADING...");
                              }
                              return RefreshIndicator(
                                onRefresh: () => _refreshData(
                                  widget.settings.arguments as String,
                                  me!.id,
                                ),
                                child: CustomScrollView(
                                  key: PageStorageKey<String>(tabs[0]),
                                  slivers: [
                                    SliverOverlapInjector(
                                      handle: NestedScrollView
                                          .sliverOverlapAbsorberHandleFor(
                                              context),
                                    ),
                                    name != '아이템'
                                        ? GridItems(
                                            name: name,
                                            userData: _userDetailData!,
                                          )
                                        : const SliverToBoxAdapter(
                                            child: Column(
                                              children: [
                                                SizedBox(height: 32),
                                                Text("준비중입니다"),
                                              ],
                                            ),
                                          ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ))
                    .toList()),
          ),
        ),
      ),
    );
  }
}

class GridItems extends StatelessWidget {
  final String name;
  final UserDetailData userData;
  const GridItems({
    super.key,
    required this.name,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: Builder(builder: (context) {
        switch (name) {
          case "검사결과":
            if (userData.scanResultList.isNotEmpty) {
              return SliverGrid.count(
                crossAxisCount: 3,
                children: userData.scanResultList
                    .asMap()
                    .entries
                    .map(
                      (data) => GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/ProfileScanList",
                              arguments: ProfileScanResultsArgs(
                                selectedId: data.key,
                                data: userData.scanResultList,
                              ));
                        },
                        child: Image.network(data.value.imgUrl),
                      ),
                    )
                    .toList(),
              );
            } else {
              return const SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(height: 32),
                    Text("검사이력이 없습니다"),
                    SizedBox(height: 16),
                  ],
                ),
              );
            }

          case "배틀이력":
            if (userData.curBattleList.isNotEmpty ||
                userData.prevBattleList.isNotEmpty) {
              return SliverGrid.count(
                crossAxisCount: 3,
                children: userData.curBattleList
                        .asMap()
                        .entries
                        .map(
                          (data) => GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/ProfileBattleList",
                                  arguments: ProfileBattlesListArgs(
                                      selectedId: data.key,
                                      data: userData.curBattleList +
                                          userData.prevBattleList,
                                      userId: userData.user.id));
                            },
                            child: Image.network(
                              userData.user.id == data.value.applicantId
                                  ? data.value.applicantUrl
                                  : data.value.opponentUrl,
                            ),
                          ),
                        )
                        .toList() +
                    userData.prevBattleList
                        .asMap()
                        .entries
                        .map(
                          (data) => GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/ProfileBattleList",
                                  arguments: ProfileBattlesListArgs(
                                    selectedId: userData.curBattleList.length +
                                        data.key,
                                    data: userData.curBattleList +
                                        userData.prevBattleList,
                                    userId: userData.user.id,
                                  ));
                            },
                            child: Stack(
                              children: [
                                Image.network(
                                  userData.user.id == data.value.applicantId
                                      ? data.value.applicantUrl
                                      : data.value.opponentUrl,
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.black54,
                                  ),
                                ),
                                Positioned(
                                  top: MediaQuery.of(context).size.width / 6,
                                  left: MediaQuery.of(context).size.width / 6,
                                  child: FractionalTranslation(
                                    translation: const Offset(-0.5, -0.5),
                                    child: Transform.rotate(
                                      angle: -45,
                                      child: ResultText(
                                        data: data.value,
                                        myId: userData.user.id,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                        .toList(),
              );
            } else {
              return const SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(height: 32),
                    Text("배틀이력이 없습니다"),
                    SizedBox(height: 16),
                  ],
                ),
              );
            }

          default:
            return SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  const Text("아직 검사를 한번도 안했어요!"),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.black87,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, "/BattleCreateScreen");
                      },
                      child:
                          const Text("배틀 생성하기", style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            );
        }
      }),
    );
  }
}

class HomeSliverAppBar extends SliverPersistentHeaderDelegate {
  final UserDetailData? userData;
  final double expandedHeight;
  final double height;
  final TabBar tabbar;
  final String friendStatus;
  final VoidCallback requestFriend;
  final int friendsCount;

  HomeSliverAppBar({
    required this.userData,
    required this.expandedHeight,
    required this.tabbar,
    required this.height,
    required this.friendStatus,
    required this.requestFriend,
    required this.friendsCount,
  });
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var me = Provider.of<AuthProvider>(context).member;
    final double percentage = shrinkOffset / (expandedHeight - height);
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Container(
          height: 150,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            image: DecorationImage(
              image: AssetImage('assets/images/bg/bg2.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          width: MediaQuery.of(context).size.width,
          height: expandedHeight / 2.5 -
              (expandedHeight / 2.5 - height) * percentage,
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/bg/bg2.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
        // 스크롤 후 appbar
        Builder(builder: (context) {
          if (userData != null) {
            return Positioned(
              top: 16,
              left: 40,
              child: Opacity(
                opacity: percentage,
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    CircleAvatar(
                      radius: 16,
                      backgroundImage:
                          NetworkImage(userData!.user.profileImage),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      userData!.user.nickname,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Positioned(
            top: 16,
            child: Opacity(
              opacity: percentage,
              child: const Row(
                children: [
                  SizedBox(width: 16),
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: AssetImage('assets/images/anonymous.png'),
                  ),
                  SizedBox(width: 16),
                  Text(
                    '--- Profile',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
        // scroll이전
        Builder(
          builder: (context) {
            return Positioned(
              top: 16 - shrinkOffset,
              right: 0,
              child: Opacity(
                opacity: (1 - percentage),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        userData != null ? userData!.user.nickname : "---",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          height: 1.6,
                        ),
                      ),
                      // SizedBox(height: 32.0),
                      const SizedBox(height: 32.0),
                      CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
                          userData != null
                              ? userData!.user.profileImage
                              : "https://image.bugsm.co.kr/artist/images/1000/802570/80257085.jpg",
                        ),
                      ),
                      const SizedBox(height: 32.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  "/FriendsListScreen",
                                  arguments: userData!.user.id,
                                );
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/icons/friends.png',
                                    color: Colors.black,
                                    fit: BoxFit.fitWidth,
                                    width: 48,
                                    height: 48,
                                  ),
                                  const SizedBox(height: 6),
                                  Builder(builder: (context) {
                                    return Text(
                                      friendsCount.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    );
                                  }),
                                  const SizedBox(height: 6),
                                  const Text('친구목록'),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 2,
                            height: 124,
                            color: Colors.black.withOpacity(0.2),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  "/ProfileReceivedBattle",
                                  arguments: userData,
                                );
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/icons/battle_bubble.png',
                                    color: Colors.black,
                                    fit: BoxFit.fitWidth,
                                    width: 48,
                                    height: 48,
                                  ),
                                  Builder(builder: (context) {
                                    return Text(
                                      userData != null
                                          ? userData!.receivedBattles.length
                                              .toString()
                                          : '-',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    );
                                  }),
                                  const SizedBox(height: 12),
                                  const Text('걸려온 배틀'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        // bottom tabbar
        Positioned(
          bottom: 0,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Center(child: tabbar),
          ),
        ),
        Positioned(
          top: 8,
          left: 8,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_sharp),
            color: Colors.black,
            iconSize: 24,
          ),
        ),
        Positioned(
          top: 22,
          right: 16,
          child: TextButton(
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () {
              requestFriend();
              UserService.requestFriend(
                  friendId: userData!.user.id, myId: me!.id);
            },
            child: Text(
              friendStatus == "NONE"
                  ? "친구신청"
                  : friendStatus == "WAITING"
                      ? "수락대기중"
                      : "친구",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: friendStatus == "NONE"
                    ? Colors.green
                    : friendStatus == "WAITING"
                        ? Colors.blueGrey
                        : Colors.amber,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
