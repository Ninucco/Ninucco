import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ninucco/models/user_detail_model.dart';
import 'package:ninucco/providers/auth_provider.dart';
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
  late TabController _tabController = TabController(length: 3, vsync: this);
  late String userId;
  late bool canGoBack;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var me = Provider.of<AuthProvider>(context).member;
    Future<UserDetailData> userData =
        UserService.getUserDetailById(me?.id ?? "linga");

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
                sliver: SliverPersistentHeader(
                  pinned: true,
                  delegate: HomeSliverAppBar(
                    expandedHeight: 450.0,
                    height: 96,
                    tabbar: myTabBar,
                    userData: userData,
                  ),
                ),
              ),
            ],
            body: TabBarView(
                controller: _tabController,
                children: tabs
                    .map((name) => SafeArea(
                          top: false,
                          bottom: false,
                          child: Builder(
                            builder: (BuildContext context) {
                              return CustomScrollView(
                                key: PageStorageKey<String>(tabs[0]),
                                slivers: [
                                  SliverOverlapInjector(
                                    handle: NestedScrollView
                                        .sliverOverlapAbsorberHandleFor(
                                            context),
                                  ),
                                  name == '검사결과'
                                      ? GridItems(
                                          name: name,
                                          userData: userData,
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
  final Future<UserDetailData> userData;
  const GridItems({
    super.key,
    required this.name,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: FutureBuilder(
          future: userData,
          builder: (context, snapshot) {
            return SliverGrid.count(
              crossAxisCount: 3,
              children: snapshot.hasData
                  ? name == '검사결과'
                      ? snapshot.data!.scanResultList
                          .asMap()
                          .entries
                          .map(
                            (data) => GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, "/ProfileScanList",
                                    arguments: ProfileScanResultsArgs(
                                      selectedId: data.key,
                                      data: snapshot.data!.scanResultList,
                                    ));
                              },
                              child: Image.network(data.value.imgUrl),
                            ),
                          )
                          .toList()
                      : name == '아이템'
                          ? snapshot.data!.itemList
                              .map(
                                (e) => GestureDetector(
                                  onTap: () {},
                                  child: Image.network(e.imgUrl),
                                ),
                              )
                              .toList()
                          : snapshot.data!.prevBattleList
                              .map(
                                (e) => GestureDetector(
                                  onTap: () {},
                                  child: Image.network(e.imgUrl),
                                ),
                              )
                              .toList()
                  : [const Text("No Data")],
            );
          }),
    );
  }
}

class HomeSliverAppBar extends SliverPersistentHeaderDelegate {
  final Future<UserDetailData> userData;
  final double expandedHeight;
  final double height;
  final TabBar tabbar;

  HomeSliverAppBar({
    required this.userData,
    required this.expandedHeight,
    required this.tabbar,
    required this.height,
  });
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
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
        FutureBuilder(
            future: userData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print("snapshotsnapshotsnapshotsnapshotsnapshot");

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
                              NetworkImage(snapshot.data!.user.profileImage),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          '${snapshot.data!.user.nickname}\'s Profile',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
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
                        backgroundImage:
                            AssetImage('assets/images/anonymous.png'),
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
        FutureBuilder(
          future: userData,
          builder: (context, snapshot) {
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
                        '${snapshot.hasData ? snapshot.data!.user.nickname : "---"} 환영합니다',
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          height: 1.6,
                        ),
                      ),
                      // SizedBox(height: 32.0),
                      const SizedBox(height: 16.0),
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 80,
                            backgroundImage: NetworkImage(snapshot.hasData
                                ? snapshot.data!.user.profileImage
                                : "https://image.bugsm.co.kr/artist/images/1000/802570/80257085.jpg"),
                          ),
                          Positioned(
                            bottom: 0,
                            right: -6,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(8),
                                backgroundColor:
                                    Colors.white, // <-- Button color
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.black,
                                size: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 32.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
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
                                FutureBuilder(
                                    future: userData,
                                    builder: (context, snapshot) {
                                      return Text(
                                        snapshot.hasData
                                            ? snapshot.data!.friendList.length
                                                .toString()
                                            : '-',
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
                          Container(
                            width: 2,
                            height: 124,
                            color: Colors.black.withOpacity(0.2),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/icons/battle_bubble.png',
                                  color: Colors.black,
                                  fit: BoxFit.fitWidth,
                                  width: 48,
                                  height: 48,
                                ),
                                FutureBuilder(
                                    future: userData,
                                    builder: (context, snapshot) {
                                      return Text(
                                        snapshot.hasData
                                            ? snapshot
                                                .data!.curBattleList.length
                                                .toString()
                                            : '-',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      );
                                    }),
                                const SizedBox(height: 12),
                                const Text('진행중인 배틀'),
                              ],
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
          right: 8,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_sharp),
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
