import 'dart:ui';

import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final RouteSettings settings;

  const ProfileScreen({super.key, required this.settings});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("_tabController.index");
    print(_tabController.index);
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/bg/bg2.png'),
          fit: BoxFit.cover,
        )),
        child: CustomScrollView(
          slivers: [
            const SliverPersistentHeader(
              pinned: true,
              delegate: HomeSliverAppBar(expandedHeight: 124.0),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const SizedBox(height: 150),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                            const Text(
                              '4',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
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
                            const Text(
                              '4',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text('진행중인 배틀'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  TabBar(
                    controller: _tabController,
                    indicatorColor: Colors.teal,
                    labelColor: Colors.teal,
                    unselectedLabelColor: Colors.black54,
                    isScrollable: true,
                    tabs: const [
                      Tab(
                        text: "One",
                      ),
                      Tab(
                        text: "Two",
                      ),
                      Tab(
                        text: "Three",
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 190,
                    child: TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.blueAccent,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.orangeAccent,
                          ),
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 100,
                            itemBuilder: (context, index) {
                              return const Text("data");
                            },
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.greenAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HomeSliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  const HomeSliverAppBar({required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: expandedHeight,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/bg/bg2.png'),
                    fit: BoxFit.cover,
                  )),
            ),
          ),
        ),
        Center(
          child: Opacity(
            opacity: shrinkOffset / expandedHeight,
            child: const Row(
              children: [
                SizedBox(width: 16),
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                      'https://image.bugsm.co.kr/artist/images/1000/802570/80257085.jpg'),
                ),
                SizedBox(width: 16),
                Text(
                  '승송현\'s Profile',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 16 - shrinkOffset,
          right: 0,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    '승송현님 환영합니다',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      height: 1.6,
                    ),
                  ),
                  // SizedBox(height: 32.0),
                  const SizedBox(height: 16.0),
                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(
                            'https://image.bugsm.co.kr/artist/images/1000/802570/80257085.jpg'),
                      ),
                      Positioned(
                        bottom: 0,
                        right: -6,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(8),
                            backgroundColor: Colors.white, // <-- Button color
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
                ],
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
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
