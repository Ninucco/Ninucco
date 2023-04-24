import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/bg/bg.png'),
          fit: BoxFit.cover,
        )),
        padding: const EdgeInsets.all(10),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              toolbarHeight: 64,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              floating: true,
              elevation: 2,
              forceElevated: true,
              backgroundColor: Colors.white,
              leading: const Padding(
                padding: EdgeInsets.all(12.0),
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Color(0xffFE9BB3),
                ),
              ),
              title: const Text(
                "안녕하세요, 송승현님!",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
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
            SliverMasonryGrid.count(
              crossAxisCount: 2,
              childCount: 6,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              itemBuilder: (context, index) => GestureDetector(
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
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 10,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            "나와",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "닮은 직업상 찾기",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(color: Colors.red, height: 150.0),
                const SizedBox(height: 100),
                Container(color: Colors.purple, height: 100.0),
                const SizedBox(height: 100),
                Container(color: Colors.green, height: 200.0),
              ]),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(color: Colors.red, height: 150.0),
                const SizedBox(height: 100),
                Container(color: Colors.purple, height: 100.0),
                const SizedBox(height: 100),
                Container(color: Colors.green, height: 200.0),
              ]),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(color: Colors.red, height: 150.0),
                const SizedBox(height: 100),
                Container(color: Colors.purple, height: 100.0),
                const SizedBox(height: 100),
                Container(color: Colors.green, height: 200.0),
              ]),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(color: Colors.red, height: 150.0),
                const SizedBox(height: 100),
                Container(color: Colors.purple, height: 100.0),
                const SizedBox(height: 100),
                Container(color: Colors.green, height: 200.0),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}


  // Container(
  //               padding: const EdgeInsets.symmetric(
  //                 horizontal: 16,
  //                 vertical: 20,
  //               ),
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.circular(12),
  //                 boxShadow: [
  //                   BoxShadow(
  //                     color: Colors.grey.withOpacity(0.3),
  //                     blurRadius: 5.0,
  //                     spreadRadius: 0.0,
  //                     offset: const Offset(0, 7),
  //                   )
  //                 ],
  //               ),
  //               child: const Row(
  //                 children: [
                    // CircleAvatar(
                    //   radius: 16,
                    //   backgroundColor: Color(0xffFE9BB3),
                    // ),
  //                   SizedBox(width: 12),
  //                   Text(
  //                     "안녕하세요, 승송현님!",
  //                     style: TextStyle(
  //                       fontSize: 20,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
