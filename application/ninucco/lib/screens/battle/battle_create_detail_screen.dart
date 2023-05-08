import 'package:flutter/material.dart';
import 'package:ninucco/widgets/battle/battle_create_item_widget.dart';
import 'package:ninucco/widgets/common/my_appbar_widget.dart';

class BattleCreateDetailWidget extends StatelessWidget {
  final int memberAId;
  final String memberAImage, question, memberANickname;

  const BattleCreateDetailWidget({
    super.key,
    required this.memberAId,
    required this.memberAImage,
    required this.question,
    required this.memberANickname,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppbarWidget(
        titleText: "배틀 생성 결과",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            BattleCreateItem(
              memberAId: memberAId,
              memberAImage: memberAImage,
              question: question,
              memberANickname: memberANickname,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 5,
              ),
              width: MediaQuery.of(context).size.width * 0.75,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  backgroundColor: Colors.white,
                  shadowColor: Colors.black45,
                ),
                child: const Text(
                  '배틀 신청할 친구 검색하기',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ),
                onPressed: () => {},
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "친구가 아직 회원이 아니신가요?",
              textAlign: TextAlign.left,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 5,
              ),
              width: MediaQuery.of(context).size.width * 0.75,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  backgroundColor: Colors.black,
                  shadowColor: Colors.black45,
                ),
                child: const Text(
                  '배틀 초대 링크 생성하기',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
                onPressed: () => {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
