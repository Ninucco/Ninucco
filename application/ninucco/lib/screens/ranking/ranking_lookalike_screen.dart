import 'package:flutter/material.dart';
import 'package:ninucco/widgets/ranking/ranking_item_widget.dart';

class RankingLookalikeScreen extends StatelessWidget {
  const RankingLookalikeScreen({super.key});
  // final Future<List<UserRankInfoModel>> userRanks =

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: RankingItem(
        profileImage:
            "https://user-images.githubusercontent.com/31383362/233578360-75193691-f74b-406a-8f7b-1f481f45ab7a.png",
        nickname: "해피한 피카츄",
        topSimilarity: "어처구니 없는 고래상",
        rankIdx: 1,
      ),
    );
  }
}
