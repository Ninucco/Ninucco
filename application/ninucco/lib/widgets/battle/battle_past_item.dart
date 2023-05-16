import 'package:flutter/material.dart';
import 'package:ninucco/models/battle_info_model.dart';

class BattlePastItem extends StatelessWidget {
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

  const BattlePastItem({
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
                            child: (result == "APPLICANT")
                                ? Stack(
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.teal,
                                        ),
                                        child: Image.network(
                                          memberAImage,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const Text(
                                        "WIN",
                                        style: TextStyle(
                                          fontSize: 50,
                                        ),
                                      ),
                                    ],
                                  )
                                : Stack(
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.teal,
                                        ),
                                        child: Image.network(
                                          memberAImage,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const Text(
                                        "LOSE",
                                        style: TextStyle(
                                          fontSize: 50,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: (result == "OPPONENT")
                                ? Stack(
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.amber,
                                        ),
                                        child: Image.network(
                                          memberBImage,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const Text(
                                        "WIN",
                                        style: TextStyle(
                                          fontSize: 50,
                                        ),
                                      ),
                                    ],
                                  )
                                : Stack(
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.amber,
                                        ),
                                        child: Image.network(
                                          memberBImage,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const Text(
                                        "LOSE",
                                        style: TextStyle(
                                          fontSize: 50,
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
                    Text(memberANickname),
                    Text(
                      memberBNickname,
                    ),
                  ],
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
