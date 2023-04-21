import 'package:flutter/material.dart';
import 'package:ninucco/widgets/ranking/ranking_item_widget.dart';

class RankingBattleScreen extends StatelessWidget {
  const RankingBattleScreen({super.key});
  // final Future<List<UserRankInfoModel>> userRanks =

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: RankingItem(
        profileImage:
            "https://user-images.githubusercontent.com/31383362/233544099-2e849a75-1e32-432a-b05d-950f864d6b98.png",
        nickname: "뛰어난 수장룡",
        topSimilarity: "방금 막 자다깬 유니콘상",
        rankIdx: 1,
      ),
    );
  }
}
