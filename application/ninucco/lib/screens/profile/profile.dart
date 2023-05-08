import 'dart:ui';
import 'package:flutter/material.dart';

// import 'package:flutter/material.dart';

// class ProfileScreen extends StatefulWidget {
//   final RouteSettings settings;

//   const ProfileScreen({super.key, required this.settings});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen>
//     with TickerProviderStateMixin {
//   ScrollController scrollController = ScrollController();
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     _tabController.dispose();
//     scrollController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Container(
//         decoration: const BoxDecoration(
//             image: DecorationImage(
//           image: AssetImage('assets/images/bg/bg2.png'),
//           fit: BoxFit.cover,
//         )),
//         child: CustomScrollView(
//           slivers: [
//             const SliverPersistentHeader(
//               pinned: true,
//               delegate: HomeSliverAppBar(expandedHeight: 124.0),
//             ),
//             SliverList(
//               delegate: SliverChildListDelegate(
//                 [
//                   const SizedBox(height: 150),
// Row(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: [
//     Expanded(
//       child: Column(
//         children: [
//           Image.asset(
//             'assets/icons/friends.png',
//             color: Colors.black,
//             fit: BoxFit.fitWidth,
//             width: 48,
//             height: 48,
//           ),
//           const SizedBox(height: 6),
//           const Text(
//             '4',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 20,
//             ),
//           ),
//           const SizedBox(height: 6),
//           const Text('친구목록'),
//         ],
//       ),
//     ),
//     Container(
//       width: 2,
//       height: 124,
//       color: Colors.black.withOpacity(0.2),
//     ),
//     Expanded(
//       child: Column(
//         children: [
//           Image.asset(
//             'assets/icons/battle_bubble.png',
//             color: Colors.black,
//             fit: BoxFit.fitWidth,
//             width: 48,
//             height: 48,
//           ),
//           const Text(
//             '4',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 20,
//             ),
//           ),
//           const SizedBox(height: 12),
//           const Text('진행중인 배틀'),
//         ],
//       ),
//     ),
//   ],
// ),
// TabBar(
//   controller: _tabController,
//   indicatorColor: Colors.teal,
//   labelColor: Colors.teal,
//  unselectedLabelColor: Colors.black54,
//   isScrollable: true,
//   tabs: const [
//     Tab(
//       text: "One",
//     ),
//     Tab(
//       text: "Two",
//     ),
//     Tab(
//       text: "Three",
//     ),
//   ],
// ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height -
//                         AppBar().preferredSize.height -
//                         MediaQuery.of(context).padding.top -
//                         50 -
//                         48,
//                     child: TabBarView(
//                       controller: _tabController,
//                       children: <Widget>[
//                         Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8.0),
//                             color: Colors.blueAccent,
//                           ),
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8.0),
//                             color: Colors.orangeAccent,
//                           ),
//                           child: ListView.builder(
//                             physics: const PageScrollPhysics(),
//                             itemCount: 100,
//                             itemBuilder: (context, index) {
//                               return const Text("data");
//                             },
//                           ),
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8.0),
//                             color: Colors.greenAccent,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

class HomeSliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final double height;
  final TabBar tabbar;
  final List<String> tabs = <String>['Tab 1', 'Tab 2'];
  HomeSliverAppBar(
      {required this.expandedHeight,
      required this.tabbar,
      required this.height});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double percentage = shrinkOffset / (expandedHeight - height);
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
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
        Positioned(
          top: 16,
          child: Opacity(
            opacity: percentage,
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
        // scroll이전
        Positioned(
          top: 16 - shrinkOffset,
          right: 0,
          child: Opacity(
            opacity: (1 - percentage),
            child: SizedBox(
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
                ],
              ),
            ),
          ),
        ),
        // bottom tabbar
        Positioned(
          bottom: 0,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Center(child: tabbar),
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

class ProfileScreen extends StatefulWidget {
  final RouteSettings settings;
  const ProfileScreen({super.key, required this.settings});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  final List<String> tabs = <String>['Tab 1', 'Tab 2', 'Tab3'];

  late TabController _tabController = TabController(length: 3, vsync: this);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var myTabBar = TabBar(
      controller: _tabController,
      indicatorColor: Colors.teal,
      labelColor: Colors.teal,
      unselectedLabelColor: Colors.black54,
      isScrollable: true,
      tabs: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 4,
          child: const Tab(
            text: "검사결과",
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 4,
          child: const Tab(
            text: "아이템",
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 4,
          child: const Tab(
            text: "배틀이력",
          ),
        ),
      ],
    );

    return DefaultTabController(
      length: tabs.length, // This is the number of tabs.
      child: SafeArea(
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              // These are the slivers that show up in the "outer" scroll view.
              return <Widget>[
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverPersistentHeader(
                    pinned: true,
                    delegate: HomeSliverAppBar(
                      expandedHeight: 450.0,
                      height: 96,
                      tabbar: myTabBar,
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: tabs.map((String name) {
                return SafeArea(
                  top: false,
                  bottom: false,
                  child: Builder(
                    builder: (BuildContext context) {
                      return CustomScrollView(
                        key: PageStorageKey<String>(name),
                        slivers: <Widget>[
                          SliverOverlapInjector(
                            handle:
                                NestedScrollView.sliverOverlapAbsorberHandleFor(
                                    context),
                          ),
                          SliverPadding(
                              padding: const EdgeInsets.all(8.0),
                              sliver: SliverGrid.count(
                                crossAxisCount: 3,
                                children: [
                                  Image.asset(
                                      'assets/images/dummy/jamminhyeok.png'),
                                  Image.asset(
                                      'assets/images/dummy/jamminhyeok.png'),
                                  Image.asset(
                                      'assets/images/dummy/jamminhyeok.png'),
                                  Image.asset(
                                      'assets/images/dummy/jamminhyeok.png'),
                                  Image.asset(
                                      'assets/images/dummy/jamminhyeok.png'),
                                  Image.asset(
                                      'assets/images/dummy/jamminhyeok.png'),
                                  Image.asset(
                                      'assets/images/dummy/jamminhyeok.png'),
                                ],
                              )
                              // SliverFixedExtentList(

                              // itemExtent: 48.0,
                              // delegate: SliverChildBuilderDelegate(
                              //   (BuildContext context, int index) {
                              //     return ListTile(
                              //       title: Text('Item $index'),
                              //     );
                              //   },
                              //   childCount: 30,
                              // ),
                              // ),
                              ),
                        ],
                      );
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
