import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ninucco/utilities/scan_list_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
              SliverGrid.builder(
                itemCount: 6,
                gridDelegate: SliverQuiltedGridDelegate(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  repeatPattern: QuiltedGridRepeatPattern.inverted,
                  pattern: [
                    const QuiltedGridTile(2, 1),
                    const QuiltedGridTile(1, 1),
                    const QuiltedGridTile(1, 1),
                  ],
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/FaceScan',
                        arguments: index,
                      );
                    },
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Image.asset(
                            'assets/images/scan_items/${index + 1}.png',
                            scale: 0.1,
                            fit: BoxFit.cover,
                          ),
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
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.only(bottom: 12, top: 36),
                  child: const Text(
                    "오늘의 배틀",
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
