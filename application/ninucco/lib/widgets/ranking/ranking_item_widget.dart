import 'package:flutter/material.dart';

class RankingItem extends StatelessWidget {
  final String profileImage, nickname, topSimilarity;
  final int rankIdx;

  const RankingItem({
    super.key,
    required this.profileImage,
    required this.nickname,
    required this.topSimilarity,
    required this.rankIdx,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.blue,
        ),
        child: Row(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              "$profileImage\n",
            ),
            Text(
              "$nickname\n",
            ),
            Text(
              "$topSimilarity\n",
            ),
            Text(
              rankIdx.toString(),
            ),
          ],
        ),
      ),
    );
  }
}
