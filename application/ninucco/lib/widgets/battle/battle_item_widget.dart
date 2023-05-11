import 'package:flutter/material.dart';
import 'package:ninucco/models/battle_info_model.dart';
import 'package:percent_indicator/percent_indicator.dart';

class BattleItem extends StatelessWidget {
  final int memberAId, memberBId, battleId;
  final double ratioA, ratioB;
  final String memberAImage,
      memberBImage,
      question,
      memberANickname,
      memberBNickname;

  const BattleItem({
    super.key,
    required this.memberANickname,
    required this.memberBNickname,
    required this.memberAId,
    required this.memberAImage,
    required this.memberBId,
    required this.memberBImage,
    required this.battleId,
    required this.question,
    required this.ratioA,
    required this.ratioB,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/BattleDetailScreen',
          arguments: BattleInfoModel(
            battleId,
            memberAId,
            memberBId,
            memberAImage,
            memberANickname,
            memberBImage,
            memberBNickname,
            question,
            ratioA,
            ratioB,
          ),
        );
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Material(
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: Column(
                              children: [
                                Container(
                                  width: 150,
                                  height: 150,
                                  margin: const EdgeInsets.all(10),
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.teal,
                                  ),
                                  child: Image.network(
                                    memberAImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Text(memberANickname),
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: Column(
                              children: [
                                Container(
                                  width: 150,
                                  height: 150,
                                  margin: const EdgeInsets.all(10),
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.amber,
                                  ),
                                  child: Image.network(
                                    memberBImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Text(memberBNickname),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Image.asset(
                        'assets/images/vs.png',
                        fit: BoxFit.contain,
                        width: 70,
                        height: 70,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  question,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "$memberANickname이\n이기면 $ratioA배",
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "$memberBNickname이\n이기면 $ratioB배",
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                LinearPercentIndicator(
                  animation: true,
                  animationDuration: 500,
                  lineHeight: 10.0,
                  percent: (ratioA) / (ratioA + ratioB),
                  progressColor: Colors.blue.shade400,
                  backgroundColor: Colors.red.shade400,
                  barRadius: const Radius.elliptical(5, 3),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 3,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment(0.8, 1),
                        colors: <Color>[
                          Color(0xffd0d3fe),
                          Color(0xffddccfd),
                          Color(0xffefc9fc),
                          Color(0xfffbc6f4),
                          Color(0xfffac3dc),
                          Color(0xfff8c0c3),
                          Color(0xfff7d1bd),
                          Color(0xfff5e6ba),
                        ],
                        tileMode: TileMode.mirror,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
