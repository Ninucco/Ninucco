import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BattleCommentItem extends StatelessWidget {
  final String profileImage, nickname, content, memberId;
  final List<dynamic> createdAt;

  const BattleCommentItem({
    super.key,
    required this.profileImage,
    required this.nickname,
    required this.content,
    required this.memberId,
    required this.createdAt,
  });

  String calculate() {
    // 시간차 계산하기
    DateTime dateTime = DateTime.now();
    if (dateTime.year == createdAt[0]) {
      if (dateTime.month == createdAt[1]) {
        if (dateTime.day == createdAt[2]) {
          if (dateTime.hour == createdAt[3]) {
            if (dateTime.minute == createdAt[4]) {
              return "조금 전";
            } else {
              return "${dateTime.minute - createdAt[4]}분 전";
            }
          } else {
            return "${dateTime.hour - createdAt[3]}시간 전";
          }
        } else {
          return "${dateTime.day - createdAt[2]}일 전";
        }
      } else {
        return "${dateTime.month - createdAt[1]}개월 전";
      }
    } else {
      return "${dateTime.year - createdAt[0]}년 전";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/Profile", arguments: memberId);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 5,
        ),
        child: Row(
          children: [
            Flexible(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.pink.shade200,
                      ),
                      child: CachedNetworkImage(
                        imageUrl: profileImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 8,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      left: 15,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              nickname,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              calculate(),
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.black45,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              content,
                              style: const TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
