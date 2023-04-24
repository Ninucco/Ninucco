import 'package:flutter/material.dart';

class RankingItem extends StatelessWidget {
  final int memberAId, memberBId, battleId;
  final String memberAImage, memberBImage, question, ratioA, ratioB;

  const RankingItem({
    super.key,
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
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(15),
          width: MediaQuery.of(context).size.width * 0.9,
          height: 90,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
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
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                blurRadius: 15,
                offset: const Offset(10, 10),
                color: Colors.black.withOpacity(0.3),
              ),
            ],
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 5,
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.network(
                            memberAImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.network(
                            memberAImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
