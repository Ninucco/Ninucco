import 'package:flutter/material.dart';
import 'package:ninucco/widgets/ranking/ranking_item_widget.dart';

class RankingBattleScreen extends StatelessWidget {
  const RankingBattleScreen({super.key});

  // final Future<List<UserRankInfoModel>> userRanks = ;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.red,
      body: RankingItem(
        profileImage: "A",
        nickname: "A",
        topSimilarity: "A",
        rankIdx: 0,
      ),
    );
  }
}
