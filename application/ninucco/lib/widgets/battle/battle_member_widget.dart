import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ninucco/widgets/betting/betting_popup_widget.dart';

class BattleMemberWidget extends StatelessWidget {
  final String nickname, profileImage, type, memberId;
  final double ratio;
  final int battleId;

  const BattleMemberWidget({
    super.key,
    required this.type,
    required this.memberId,
    required this.battleId,
    required this.nickname,
    required this.profileImage,
    required this.ratio,
  });

  @override
  Widget build(BuildContext context) {
    List<String> split = nickname.split(' ');
    return Row(
      children: [
        Flexible(
          flex: 3,
          child: Container(
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
        ),
        Flexible(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    "/Profile",
                    arguments: memberId,
                  );
                },
                child: (split.length >= 5)
                    ? Column(
                        // 처음 배부된 기본 닉네임 형식인 경우
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${split[0]} ${split[1]}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${split[2]} ${split[3]} ${split[4]}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    : (nickname.length > 6)
                        ? Column(
                            // 수정된 닉네임이 7글자 이상인 경우
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                nickname.substring(0, 6),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                nickname.substring(6),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            // 수정된 닉네임이 6글자 이하인 경우
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                nickname,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    "이기면  ",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    " ${ratio.toStringAsFixed(2)}배",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const Text(
                    "를",
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "더 받을 수 있어요",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BettingPopupWidget(
                      type: type,
                      battleId: battleId,
                      memberId: memberId,
                      nickname: nickname,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
