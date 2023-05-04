import 'package:flutter/material.dart';
import 'package:ninucco/utilities/scan_list_data.dart';
import 'package:carousel_slider/carousel_slider.dart';

class NoonLoopingDemo extends StatelessWidget {
  final imgList = [
    "assets/images/dummy/jamminhyeok.png",
    "assets/images/dummy/jamminhyeok.png",
    "assets/images/dummy/jamminhyeok.png",
    "assets/images/dummy/jamminhyeok.png",
    "assets/images/dummy/jamminhyeok.png",
    "assets/images/dummy/jamminhyeok.png",
  ];

  late List<Widget> imageSliders = imgList
      .map(
        (item) => Container(
          margin: const EdgeInsets.all(5.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                Image.asset(item, fit: BoxFit.cover, width: 1000.0),
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
                        const Text(
                          '누가 더 잼민이 같나요?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${imgList.indexOf(item)} 명이 배팅했어요',
                          style: const TextStyle(
                            color: Colors.white70,
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
      .toList();

  NoonLoopingDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 2.0,
          enlargeCenterPage: true,
          enableInfiniteScroll: true,
        ),
        items: imageSliders,
      ),
    );
  }
}

class BasicDemo extends StatelessWidget {
  const BasicDemo({super.key});

  @override
  Widget build(BuildContext context) {
    List<int> list = [1, 2, 3, 4, 5, 6];
    return CarouselSlider(
      options: CarouselOptions(
          viewportFraction: 1,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 5),
          autoPlayAnimationDuration: const Duration(seconds: 1)),
      items: list
          .map((item) => Stack(
                children: [
                  Image.asset(
                    'assets/images/scan_items/card_$item.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(36),
                    child: Row(
                      mainAxisAlignment: item == 1
                          ? MainAxisAlignment.end
                          : item == 3
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: item == 1
                              ? CrossAxisAlignment.end
                              : item == 3
                                  ? CrossAxisAlignment.start
                                  : CrossAxisAlignment.center,
                          children: const [
                            Text(
                              "나는 어떤 동물을 닮았을지",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black26,
                                      offset: Offset(2, 2),
                                    ),
                                  ]),
                            ),
                            Text(
                              "검사해보세요!",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
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
                      onPressed: () {},
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(const CircleBorder()),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(8)),
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
          child: CustomScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              HomeSliverAppBar(searchController: searchController),
              const SliverToBoxAdapter(child: SizedBox(height: 12)),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: const Text(
                    "나의 닮은꼴 찾기",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: BasicDemo(),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.only(bottom: 12, top: 36),
                  child: const Text(
                    "오늘의 배틀",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: NoonLoopingDemo(),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.only(bottom: 12, top: 36),
                  child: const Text(
                    "랭킹",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    for (var _ in [1, 2, 3, 4, 5])
                      Column(
                        children: [
                          Stack(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: Image.network(
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRwVVfi9a81AcdLJQCiVitDydwOnDDiRLpcbw&usqp=CAU',
                                        scale: 0.1,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: Image.network(
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRky4seZyCNJWW8Wu3pt6AoaMMTsIZ203_xtQ&usqp=CAU',
                                        scale: 0.1,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Positioned.fill(
                                  bottom: 0,
                                  left: 0,
                                  child: Icon(
                                    Icons.brightness_auto_outlined,
                                    color: Colors.purpleAccent,
                                    size: 64,
                                  )),
                            ],
                          ),
                          const SizedBox(height: 4),
                          const Text("34명이 배팅했어요"),
                          const Divider(
                            height: 24,
                            color: Color(0x88000000),
                          )
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeSliverAppBar extends StatelessWidget {
  const HomeSliverAppBar({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
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
            const Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Color(0xffFE9BB3),
                ),
                SizedBox(width: 16),
                Text(
                  "안녕하세요, 송승현님!",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
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
