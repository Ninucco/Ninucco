import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ninucco/models/user_detail_model.dart';
import 'package:ninucco/providers/auth_provider.dart';
import 'package:ninucco/providers/nav_provider.dart';
import 'package:ninucco/screens/profile/profile_battles_list.dart';
import 'package:ninucco/screens/profile/profile_scan_result.dart';
import 'package:ninucco/services/user_service.dart';
import 'package:provider/provider.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

/// Todo
/// [] settings에서 받아온 유저 데이터로 연결하기
/// [] settings에서 받아온 유저와 provider의 유저와 비교해서 본인인지 확인
/// [] 내가 아닌경우 친구신청
/// [] 나인 경우 can edit
///

class _MyProfileScreenState extends State<MyProfileScreen>
    with TickerProviderStateMixin {
  final List<String> tabs = <String>['검사결과', '배틀이력', '아이템'];
  bool inited = false;
  late TabController _tabController = TabController(length: 3, vsync: this);
  late String userId;

  UserDetailData? _userDetailData;
  List<Friend> _receivedFriendList = [];
  List<Friend> _friendList = [];

  Future<void>? _initUserDetail;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  Future<void> _initDatas(String id) async {
    final data = await UserService.getUserDetailById(id);
    final receivedFriendsData = await UserService.getReceivedFriends(id);
    final friendsData = await UserService.getFriends(id);

    setState(() {
      _userDetailData = data;
      _receivedFriendList = receivedFriendsData;
      _friendList = friendsData;
    });
  }

  Future<void> _refreshData(String id) async {
    final data = await UserService.getUserDetailById(id);
    final receivedFriendsData = await UserService.getReceivedFriends(id);
    final friendsData = await UserService.getFriends(id);

    setState(() {
      _userDetailData = data;
      _receivedFriendList = receivedFriendsData;
      _friendList = friendsData;
    });
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    var me = authProvider.member;
    if (inited == false && me?.id != null) {
      _initUserDetail = _initDatas(me!.id);
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
                            expandedHeight: 480.0,
                            height: 108,
                            tabbar: myTabBar,
                            userData: null,
                            receivedFriendsCount: _receivedFriendList.length,
                            friendsCount: _friendList.length,
                          ),
                        );
                      }
                      return SliverPersistentHeader(
                        pinned: true,
                        delegate: HomeSliverAppBar(
                          expandedHeight: 480.0,
                          height: 108,
                          tabbar: myTabBar,
                          userData: _userDetailData,
                          receivedFriendsCount: _receivedFriendList.length,
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
                                onRefresh: () =>
                                    _refreshData(me?.id ?? "linga"),
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
    NavProvider navProvider = Provider.of<NavProvider>(context);

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
                        child: CachedNetworkImage(imageUrl: data.value.imgUrl),
                      ),
                    )
                    .toList(),
              );
            } else {
              return SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 32),
                    const Text("지금 바로 검사 하고 프로필을 받아보세요!"),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.black87,
                        ),
                        onPressed: () {
                          navProvider.to(4);
                          // Navigator.pushNamed(context, "/Category");
                        },
                        child: const Text("검사하러 가기",
                            style: TextStyle(fontSize: 16)),
                      ),
                    ),
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
                                    userId: userData.user.id,
                                  ));
                            },
                            child: CachedNetworkImage(
                              imageUrl:
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
                                CachedNetworkImage(
                                  imageUrl:
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
              return SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 32),
                    const Text("지금 바로 친구와 경쟁해보세요!"),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.black87,
                        ),
                        onPressed: () {
                          navProvider.to(2);
                        },
                        child: const Text("배틀 하러하기",
                            style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              );
            }

          default:
            return SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  const Text("지금 바로 검사 하고 프로필을 받아보세요!"),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.black87,
                      ),
                      onPressed: () {
                        navProvider.to(2);
                        // Navigator.pushNamed(context, "/BattleCreateScreen");
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

class ResultText extends StatelessWidget {
  final Battle data;
  final String myId;
  const ResultText({
    super.key,
    required this.data,
    required this.myId,
  });

  @override
  Widget build(BuildContext context) {
    var isApplicant = data.applicantId == myId;
    var isWin = isApplicant && data.result == "APPLICANT" ||
        !isApplicant && data.result != "APPLICANT";
    var battleResult = data.result == "DRAW"
        ? "DRAW"
        : isWin
            ? "WIN"
            : "LOSE";
    Map colorMap = {
      "DRAW": const Color(0xffE4E5E7),
      "WIN": const Color(0xff00fc00),
      "LOSE": const Color.fromARGB(255, 245, 73, 73),
    };
    return Builder(builder: (context) {
      return Text(
        battleResult,
        style: TextStyle(
          color: colorMap[battleResult],
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      );
    });
  }
}

class HomeSliverAppBar extends SliverPersistentHeaderDelegate {
  final UserDetailData? userData;
  final double expandedHeight;
  final double height;
  final TabBar tabbar;
  final int receivedFriendsCount;
  final int friendsCount;

  HomeSliverAppBar({
    required this.userData,
    required this.receivedFriendsCount,
    required this.expandedHeight,
    required this.tabbar,
    required this.height,
    required this.friendsCount,
  });
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double percentage = shrinkOffset / (expandedHeight - height);
    var authProvider = Provider.of<AuthProvider>(context);
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
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.monetization_on_rounded,
                              color: Colors.amber,
                            ),
                            Text(
                              "${authProvider.member?.point} 니누꼬인을 보유하고 있어요.",
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  "/ReceivedFriendsListScreen",
                                  arguments: authProvider.member!.id,
                                );
                              },
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.person_pin_outlined,
                                    size: 48,
                                  ),
                                  const SizedBox(height: 6),
                                  Builder(builder: (context) {
                                    return Text(
                                      receivedFriendsCount.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    );
                                  }),
                                  const SizedBox(height: 6),
                                  const Text('받은 친구요청'),
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
                                  "/FriendsListScreen",
                                  arguments: authProvider.member!.id,
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
          top: 6,
          right: 8,
          child: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/ProfileSettings',
                  arguments: userData);
            },
            icon: const Icon(Icons.settings),
            color: Colors.black,
            iconSize: 24,
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
