import 'package:flutter/material.dart';
import 'package:ninucco/widgets/betting/betting_popup_widget.dart';

class BattleMemberWidget extends StatelessWidget {
  final String nickname, profileImage;
  final double ratio;
  final int memberId;

  const BattleMemberWidget({
    super.key,
    required this.memberId,
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
            child: Image.network(
              profileImage,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                split[0],
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
                "${split[1]} ${split[2]}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
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
                    " $ratio배",
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
                      memberId: memberId,
                      nickname: nickname,
                      posessCoin: 10000,
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
