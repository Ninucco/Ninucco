import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Padding(
        padding: EdgeInsets.all(12.0),
        child: GridScanItems(),
      ),
    );
  }
}

class ScreenArguments {
  final String title;
  final String message;
  final int type;

  ScreenArguments(this.title, this.message, this.type);
}

class GridScanItems extends StatelessWidget {
  const GridScanItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      padding: const EdgeInsets.all(8),
      itemCount: 6,
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2),
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
    );
  }
}
