import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ninucco/models/battle_info_model.dart';
import 'package:ninucco/models/user_rank_info_model.dart';
import 'package:ninucco/services/battle_api_service.dart';
import 'package:ninucco/providers/auth_provider.dart';
import 'package:ninucco/services/user_rank_api_service.dart';
import 'package:ninucco/utilities/scan_list_data.dart';
import 'package:ninucco/widgets/ranking/ranking_item_widget.dart';
import 'package:provider/provider.dart';

class NoonLoopingDemo extends StatefulWidget {
  const NoonLoopingDemo({super.key});

  @override
  State<NoonLoopingDemo> createState() => _NoonLoopingDemoState();
}

class _NoonLoopingDemoState extends State<NoonLoopingDemo> {
  final Future<List<BattleInfoModel>> battles =
      BattleApiService.getBattles("PROCEEDING");

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: battles,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
              ),
              items: snapshot.data!
                  .map(
                    (item) => Container(
                      margin: const EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                        child: Stack(
                          children: <Widget>[
                            CachedNetworkImage(
                              imageUrl: item.memberAImage,
                              fit: BoxFit.cover,
                              width: 1000.0,
                            ),
                            Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              right: 0.0,
                              child: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromARGB(200, 0, 0, 0),
                                      Color.fromARGB(0, 0, 0, 0)
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                child: Column(
                                  children: [
                                    Text(
                                      item.question,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            );
          }
          return const Text("LOADING...");
        });
  }
}

class BasicDemo extends StatelessWidget {
  final scanList = ScanUtility().scanTitlePreviewList;
  BasicDemo({super.key});

  @override
  Widget build(BuildContext context) {
    List<int> list = [1, 2, 3, 4];
    return CarouselSlider(
      options: CarouselOptions(
          viewportFraction: 1,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 5),
          autoPlayAnimationDuration: const Duration(seconds: 1)),
      items: list
          .map((item) => GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/FaceScan',
                    arguments: item - 1,
                  );
                },
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/scan_items/card_$item.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(36),
                      child: Row(
                        mainAxisAlignment: item == 1 || item == 4
                            ? MainAxisAlignment.end
                            : item == 3
                                ? MainAxisAlignment.start
                                : MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: item == 1 || item == 4
                                ? CrossAxisAlignment.end
                                : item == 3
                                    ? CrossAxisAlignment.start
                                    : CrossAxisAlignment.center,
                            children: [
                              Text(
                                scanList[item - 1][0],
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                scanList[item - 1][1],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black26,
                                        offset: Offset(2, 2),
                                      ),
                                    ]),
                              ),
                              Text(
                                scanList[item - 1][2],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black26,
                                        offset: Offset(2, 2),
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      right: 16,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/FaceScan',
                            arguments: item - 1,
                          );
                        },
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all(const CircleBorder()),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(8)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                        child: const Icon(
                          Icons.chevron_right,
                          color: Colors.black87,
                        ),
                      ),
                    )
                  ],
                ),
              ))
          .toList(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Future<List<UserRankInfoModel>> userRanks =
      UserRankApiService.getTop5UserRanks();

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/bg/bg.png'),
            fit: BoxFit.cover,
          )),
          child: CustomScrollView(
            physics: const RangeMaintainingScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              HomeSliverAppBar(searchController: searchController),
              const SliverToBoxAdapter(child: SizedBox(height: 12)),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "나의 닮은꼴 찾기",
                        style: TextStyle(fontSize: 17),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/Category');
                          },
                          child: const Row(
                            children: [
                              Text(
                                "전체보기",
                                style: TextStyle(color: Colors.black87),
                              ),
                              Icon(Icons.chevron_right, color: Colors.black54)
                            ],
                          ))
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: BasicDemo(),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 24),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "인기 배틀",
                        style: TextStyle(fontSize: 17),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: const Row(
                            children: [
                              Text(
                                "전체보기",
                                style: TextStyle(color: Colors.black87),
                              ),
                              Icon(Icons.chevron_right, color: Colors.black54)
                            ],
                          ))
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: NoonLoopingDemo(),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 35),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "배틀 우승 랭킹",
                        style: TextStyle(fontSize: 17),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: const Row(
                            children: [
                              Text(
                                "전체보기",
                                style: TextStyle(color: Colors.black87),
                              ),
                              Icon(Icons.chevron_right, color: Colors.black54)
                            ],
                          ))
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 400,
                    child: FutureBuilder(
                      future: userRanks,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView(
                            padding: const EdgeInsets.all(0),
                            physics: const NeverScrollableScrollPhysics(),
                            children: [makeList(snapshot)],
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

ListView makeList(AsyncSnapshot<List<UserRankInfoModel>> snapshot) {
  return ListView.separated(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: snapshot.data!.length,
    itemBuilder: (context, index) {
      var userRank = snapshot.data![index];
      return RankingItem(
        memberId: userRank.memberId,
        profileImage: userRank.profileImage,
        nickname: userRank.nickname,
        winCount: userRank.winCount,
        index: index,
        type: "BATTLE",
        onTap: () {
          Navigator.pushNamed(
            context,
            "/Profile",
            arguments: userRank.memberId,
          );
        },
      );
    },
    separatorBuilder: (context, index) => const SizedBox(width: 0),
  );
}

class HomeSliverAppBar extends StatelessWidget {
  const HomeSliverAppBar({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return SliverAppBar(
      toolbarHeight: 160,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      elevation: 0,
      forceElevated: true,
      backgroundColor: Colors.white.withOpacity(0.6),
      leadingWidth: 0,
      title: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              const CircleAvatar(
                radius: 16,
                backgroundColor: Color(0xffFE9BB3),
              ),
              const SizedBox(width: 16),
              Text(
                "안녕하세요,\n${authProvider.member?.nickname ?? '익명의 사용자'}님!",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ]),
            const SizedBox(height: 8),
            const Text(
              "친구를 찾아서 경쟁해보세요!",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  const Color(0xffF7D1ED).withOpacity(0.7),
                  const Color(0xffC8CDFA).withOpacity(0.7),
                ]),
                borderRadius: BorderRadius.circular(6),
              ),
              child: SearchInput(controller: searchController),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchInput extends StatelessWidget {
  final TextEditingController controller;
  const SearchInput({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.go,
      onFieldSubmitted: (value) async {
        Navigator.pushNamed(context, '/Search', arguments: value);
      },
      controller: controller,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: "친구검색",
        prefixIcon: Icon(Icons.search),
      ),
    );
  }
}
