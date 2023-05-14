import 'package:flutter/material.dart';
import 'package:ninucco/services/user_rank_api_service.dart';
import 'package:ninucco/widgets/ranking/ranking_item_widget.dart';
import 'package:ninucco/models/user_rank_info_model.dart';

class RankingBattleScreen extends StatelessWidget {
  RankingBattleScreen({super.key});

  final Future<List<UserRankInfoModel>> userRanks =
      UserRankApiService.getUserRanks();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg/bg2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder(
          future: userRanks,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  const SizedBox(
                    height: 20,
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
      ),
    );
  }

  static ListView makeList(AsyncSnapshot<List<UserRankInfoModel>> snapshot) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        var userRank = snapshot.data![index];
        return RankingItem(
          memberId: userRank.memberId,
          profileImage: userRank.profileImage,
          nickname: userRank.nickname,
          winCount: userRank.winCount,
          index: index,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 40),
    );
  }
}
