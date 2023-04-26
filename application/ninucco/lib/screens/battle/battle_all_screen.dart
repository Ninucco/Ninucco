import 'package:flutter/material.dart';
import 'package:ninucco/services/user_rank_api_service.dart';
import 'package:ninucco/widgets/battle/battle_item_widget.dart';
import 'package:ninucco/models/user_rank_info_model.dart';

class BattleAllScreen extends StatelessWidget {
  BattleAllScreen({super.key});

  // final Future<List<UserRankInfoModel>> userRanks =
  //     UserRankApiService.getUserRanks();

  final Future<List<UserRankInfoModel>> userRanks =
      UserRankApiService.getUserRanks();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios_new_outlined,
        //       color: Colors.black),
        //   onPressed: () => Navigator.of(context).pop(),
        // ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          '전체 배틀',
        ),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: userRanks,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [Expanded(child: makeList(snapshot))],
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
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        var userRank = snapshot.data![index];
        return BattleItem(
          memberAId: 1,
          memberANickname: "무서운 갈라파고스 장인훅",
          memberAImage: userRank.profileImage,
          memberBId: 1,
          memberBNickname: "무서운 갈라파고스 하훈묵",
          memberBImage: userRank.profileImage,
          battleId: userRank.id,
          question: "누가 더 백엔드 개발자처럼 생겼나요?",
          ratioA: 3.0,
          ratioB: 1.3,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 40),
    );
  }
}
