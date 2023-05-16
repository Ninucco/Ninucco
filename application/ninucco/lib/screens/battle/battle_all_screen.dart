import 'package:flutter/material.dart';
import 'package:ninucco/models/battle_info_model.dart';
import 'package:ninucco/services/battle_api_service.dart';
import 'package:ninucco/widgets/battle/battle_item_widget.dart';

class BattleActiveScreen extends StatefulWidget {
  const BattleActiveScreen({super.key});

  @override
  State<BattleActiveScreen> createState() => _BattleActiveScreenState();
}

class _BattleActiveScreenState extends State<BattleActiveScreen> {
  List<BattleInfoModel>? battles;
  Future<void>? initBattles;
  bool inited = false;
  bool refreshed = false;

  Future<void> _refreshData() async {
    final data = await BattleApiService.getBattles("PROCEEDING");
    setState(() {
      battles = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (inited == false) {
      _refreshData();
      inited = true;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () {
          _refreshData();
          return Future<void>.delayed(const Duration(seconds: 1));
        },
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg/bg2.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: (battles != null)
              ? makeList(battles!)
              : const Column(
                  children: [
                    SizedBox(height: 32),
                    Text("준비중입니다"),
                  ],
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/BattleCreateScreen',
          );
        },
        backgroundColor: Colors.blue.shade600,
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
    );
  }

  ListView makeList(List<BattleInfoModel> battleInfo) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: battleInfo.length,
      itemBuilder: (context, index) {
        var userRank = battleInfo[index];
        return BattleItem(
          memberAId: userRank.memberAId,
          memberANickname: userRank.memberANickname,
          memberAImage: userRank.memberAImage,
          memberBId: userRank.memberBId,
          memberBNickname: userRank.memberBNickname,
          memberBImage: userRank.memberBImage,
          battleId: userRank.battleId,
          question: userRank.question,
          ratioA: userRank.ratioA,
          ratioB: userRank.ratioB,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 40),
    );
  }
}
