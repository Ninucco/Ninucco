import 'package:flutter/material.dart';
import 'package:ninucco/widgets/ranking/ranking_item_widget.dart';
import 'package:ninucco/services/user_rank_api_service.dart';
import 'package:ninucco/models/user_rank_info_model.dart';

class LoginGoogleScreen extends StatelessWidget {
  LoginGoogleScreen({super.key});

  final Future<List<UserRankInfoModel>> userRanks =
      UserRankApiService.getUserRanks();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: userRanks,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Expanded(child: makeList(snapshot))
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<UserRankInfoModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data!.length,
      // padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemBuilder: (context, index) {
        var userRank = snapshot.data![index];
        return RankingItem(
          id: userRank.id,
          profileImage: userRank.profileImage,
          nickname: "뛰어난 수장룡",
          topSimilarity: "방금 막 자다깬 유니콘상",
          index: index,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 40),
    );
  }
}
