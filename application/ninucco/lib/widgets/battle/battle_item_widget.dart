import 'package:flutter/material.dart';
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
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Stack(
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
                                  margin: const EdgeInsets.all(10),
                                  width: 200,
                                  height: 200,
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
                                  margin: const EdgeInsets.all(10),
                                  width: 200,
                                  height: 200,
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
                          "$memberANickname이 이기면 $ratioA배",
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "$memberBNickname이 이기면 $ratioB배",
                          style: const TextStyle(
                            fontSize: 12,
                          ),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
