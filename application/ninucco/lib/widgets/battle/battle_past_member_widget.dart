import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BattlePastMemberWidget extends StatelessWidget {
  final String nickname, profileImage, type, memberId, result;
  final double ratio;
  final int battleId;

  const BattlePastMemberWidget({
    super.key,
    required this.type,
    required this.memberId,
    required this.battleId,
    required this.nickname,
    required this.profileImage,
    required this.ratio,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (type == "APPLICANT")
          ? Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      "/Profile",
                      arguments: memberId,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 200,
                            height: 200,
                            margin: const EdgeInsets.only(
                              right: 10,
                            ),
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.amber,
                            ),
                            child: CachedNetworkImage(
                              imageUrl: profileImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            nickname,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          (result == "APPLICANT")
                              ? const Text(
                                  "WIN",
                                  style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffA459D1),
                                    shadows: [
                                      Shadow(
                                        blurRadius: 2.0, // shadow blur
                                        color: Colors.white, // shadow color
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
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xffFFB84C),
                                        shadows: [
                                          Shadow(
                                            blurRadius: 2.0, // shadow blur
                                            color: Colors.white, // shadow color
                                            offset: Offset(1.0,
                                                1.0), // how much shadow will be shown
                                          ),
                                        ],
                                      ),
                                    )
                                  : const Text(
                                      "LOSE",
                                      style: TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xffF266AB),
                                        shadows: [
                                          Shadow(
                                            blurRadius: 2.0, // shadow blur
                                            color: Colors.white, // shadow color
                                            offset: Offset(1.0,
                                                1.0), // how much shadow will be shown
                                          ),
                                        ],
                                      ),
                                    ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      "/Profile",
                      arguments: memberId,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          (result == "OPPONENT")
                              ? const Text(
                                  "WIN",
                                  style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffA459D1),
                                    shadows: [
                                      Shadow(
                                        blurRadius: 2.0, // shadow blur
                                        color: Colors.white, // shadow color
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
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xffFFB84C),
                                        shadows: [
                                          Shadow(
                                            blurRadius: 2.0, // shadow blur
                                            color: Colors.white, // shadow color
                                            offset: Offset(1.0,
                                                1.0), // how much shadow will be shown
                                          ),
                                        ],
                                      ),
                                    )
                                  : const Text(
                                      "LOSE",
                                      style: TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xffF266AB),
                                        shadows: [
                                          Shadow(
                                            blurRadius: 2.0, // shadow blur
                                            color: Colors.white, // shadow color
                                            offset: Offset(1.0,
                                                1.0), // how much shadow will be shown
                                          ),
                                        ],
                                      ),
                                    ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 200,
                            height: 200,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.amber,
                            ),
                            child: CachedNetworkImage(
                              imageUrl: profileImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            nickname,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
