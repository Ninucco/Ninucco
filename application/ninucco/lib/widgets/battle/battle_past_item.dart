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
          '/BattlePastDetailScreen',
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
                            child: Stack(
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
                                  child: Image.network(
                                    memberAImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
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
                                    color: Colors.black54,
                                  ),
                                ),
                                Container(
                                  width: 150,
                                  height: 150,
                                  margin: const EdgeInsets.only(
                                    right: 20,
                                    bottom: 10,
                                    top: 10,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      (result == "APPLICANT")
                                          ? const Text(
                                              "WIN",
                                              style: TextStyle(
                                                fontSize: 40,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xffA459D1),
                                                shadows: [
                                                  Shadow(
                                                    blurRadius:
                                                        2.0, // shadow blur
                                                    color: Colors
                                                        .white, // shadow color
                                                    offset: Offset(1.0,
                                                        1.0), // how much shadow will be shown
                                                  ),
                                                ],
                                              ),
                                            )
                                          : (result == "DRAW")
                                              ? const Text(
                                                  "DRAW",
                                                  style: TextStyle(
                                                    fontSize: 40,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xffFFB84C),
                                                    shadows: [
                                                      Shadow(
                                                        blurRadius:
                                                            2.0, // shadow blur
                                                        color: Colors
                                                            .white, // shadow color
                                                        offset: Offset(1.0,
                                                            1.0), // how much shadow will be shown
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : const Text(
                                                  "LOSE",
                                                  style: TextStyle(
                                                    fontSize: 40,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xffF266AB),
                                                  ),
                                                ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: Stack(
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
                                  child: Image.network(
                                    memberBImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
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
                                    color: Colors.black54,
                                  ),
                                ),
                                Container(
                                  width: 150,
                                  height: 150,
                                  margin: const EdgeInsets.only(
                                    left: 20,
                                    bottom: 10,
                                    top: 10,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      (result == "OPPONENT")
                                          ? const Text(
                                              "WIN",
                                              style: TextStyle(
                                                fontSize: 40,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xffA459D1),
                                                shadows: [
                                                  Shadow(
                                                    blurRadius:
                                                        2.0, // shadow blur
                                                    color: Colors
                                                        .white, // shadow color
                                                    offset: Offset(1.0,
                                                        1.0), // how much shadow will be shown
                                                  ),
                                                ],
                                              ),
                                            )
                                          : (result == "DRAW")
                                              ? const Text(
                                                  "DRAW",
                                                  style: TextStyle(
                                                    fontSize: 40,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xffFFB84C),
                                                    shadows: [
                                                      Shadow(
                                                        blurRadius:
                                                            2.0, // shadow blur
                                                        color: Colors
                                                            .white, // shadow color
                                                        offset: Offset(1.0,
                                                            1.0), // how much shadow will be shown
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : const Text(
                                                  "LOSE",
                                                  style: TextStyle(
                                                    fontSize: 40,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xffF266AB),
                                                    shadows: [
                                                      Shadow(
                                                        blurRadius:
                                                            2.0, // shadow blur
                                                        color: Colors
                                                            .white, // shadow color
                                                        offset: Offset(1.0,
                                                            1.0), // how much shadow will be shown
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          right: 5,
                        ),
                        child: Image.asset(
                          'assets/images/vs.png',
                          fit: BoxFit.contain,
                          width: 70,
                          height: 70,
                        ),
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
