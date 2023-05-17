import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ninucco/models/battle_info_model.dart';
import 'package:percent_indicator/percent_indicator.dart';

class BattleItem extends StatelessWidget {
  final int battleId;
  final double ratioA, ratioB;
  final String memberAImage,
      memberBImage,
      question,
      memberANickname,
      memberBNickname,
      memberAId,
      memberBId,
      result;

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
    required this.result,
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
            result,
          ),
        );
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            margin: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  question,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17),
                ),
                const SizedBox(
                  height: 20,
                ),
                Material(
                  color: Colors.transparent,
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
                                  margin: const EdgeInsets.only(
                                    right: 20,
                                    bottom: 10,
                                    top: 10,
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.teal,
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: memberAImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
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
                                  margin: const EdgeInsets.only(
                                    left: 20,
                                    bottom: 10,
                                    top: 10,
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.amber,
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: memberBImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      memberANickname,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      memberBNickname,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "여기가 이기면 $ratioA배",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "여기가 이기면 $ratioB배",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
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
                  padding: const EdgeInsets.all(0),
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
