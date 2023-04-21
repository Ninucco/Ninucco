import 'package:flutter/material.dart';
import 'package:ninucco/widgets/ranking/ranking_item_widget.dart';

class RankingBettingScreen extends StatelessWidget {
  const RankingBettingScreen({super.key});

  // final Future<List<UserRankInfoModel>> userRanks =

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: RankingItem(
        profileImage:
            "https://user-images.githubusercontent.com/31383362/233578460-38695d62-c744-42e4-b420-680c5aa243a6.png",
        nickname: "천재 모티",
        topSimilarity: "누가 뭐래도 퀸카상",
        rankIdx: 1,
      ),
    );
  }
}
