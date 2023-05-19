import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ninucco/providers/nav_provider.dart';
import 'package:ninucco/utilities/scan_list_data.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final scanList = ScanUtility().scanTitleList;

    final searchController = TextEditingController();

    @override
    void dispose() {
      searchController.dispose();
      super.dispose();
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/bg/bg.png'),
            fit: BoxFit.cover,
          )),
          child: SafeArea(
            child: CustomScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: [
                const SliverPersistentHeader(
                  pinned: true,
                  delegate: HomeSliverAppBar(),
                ),
                // const HomeSliverAppBar(),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 48),
                ),
                SliverMasonryGrid.count(
                  crossAxisCount: 2,
                  childCount: 5,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  itemBuilder: (context, i) {
                    var index = i % 6;
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/FaceScan',
                          arguments: index,
                        );
                      },
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/images/scan_items/${index + 1}.png',
                            scale: 0.1,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 10,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                Text(
                                  scanList[index][0],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  scanList[index][1],
                                  style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 6.0,
                                        color: Colors.black12,
                                        offset: Offset(2, 2),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  scanList[index][2],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 36)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeSliverAppBar extends SliverPersistentHeaderDelegate {
  const HomeSliverAppBar();
  final double expandedHeight = 124;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var navIndex = Provider.of<NavProvider>(context).index;
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Container(
          width: 32,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            color: Colors.white.withOpacity(0.8),
          ),
          child: navIndex != 4
              ? IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                )
              : const SizedBox(),
        ),
        Center(
          child: Opacity(
            opacity: shrinkOffset / expandedHeight,
            child: const Text(
              '나는 어떤 상일까?',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 23,
              ),
            ),
          ),
        ),
        Positioned(
          top: expandedHeight / 4 - shrinkOffset,
          right: 0,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              width: MediaQuery.of(context).size.width,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '무슨 얼굴 상일지 테스트 해봐요!',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("내가 어떤상인지 검사하고, ninu코인과 AI가 그려주는 프로필 사진을 획득하세요"),
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
