import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RankingItem extends StatelessWidget {
  final String profileImage, nickname, memberId, type;
  final int winCount, index;
  final VoidCallback onTap;

  const RankingItem({
    super.key,
    required this.memberId,
    required this.profileImage,
    required this.nickname,
    required this.winCount,
    required this.index,
    required this.onTap,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 20,
            ),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 2,
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: profileImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 8,
                  fit: FlexFit.tight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          nickname,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        (type == "BATTLE")
                            ? Text("우승 총 $winCount 회")
                            : (type == "ELO")
                                ? Text("$winCount 점")
                                : Text("$winCount 포인트 보유"),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: getPrizeIcon(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getPrizeIcon() {
    if (index == 0) {
      return Image.asset(
        'assets/images/first_place.png',
        fit: BoxFit.contain,
      );
    } else if (index == 1) {
      return Image.asset(
        'assets/images/second_place.png',
        fit: BoxFit.contain,
      );
    } else if (index == 2) {
      return Image.asset(
        'assets/images/third_place.png',
        fit: BoxFit.contain,
      );
    } else {
      return const SizedBox(height: 10);
    }
  }
}
