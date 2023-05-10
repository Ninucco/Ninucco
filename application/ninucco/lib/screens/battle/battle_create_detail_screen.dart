import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ninucco/screens/battle/battle_friend_search.dart';
import 'package:ninucco/widgets/battle/battle_create_item_widget.dart';
import 'package:ninucco/widgets/common/my_appbar_widget.dart';

class BattleCreateDetailWidget extends StatefulWidget {
  final int memberAId;
  final String question, memberANickname;
  final File memberAImage;

  const BattleCreateDetailWidget({
    super.key,
    required this.memberAId,
    required this.memberAImage,
    required this.question,
    required this.memberANickname,
  });

  @override
  State<BattleCreateDetailWidget> createState() =>
      _BattleCreateDetailWidgetState();
}

class _BattleCreateDetailWidgetState extends State<BattleCreateDetailWidget> {
  var result = "???";

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
              memberAId: widget.memberAId,
              memberAImage: widget.memberAImage,
              question: widget.question,
              memberANickname: widget.memberANickname,
              memberBNickname: result,
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
                onPressed: () async {
                  var tmpResult = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BattleFriendSearchScreen(
                        keyword: "",
                      ),
                    ),
                  );

                  setState(() {
                    result = tmpResult;
                  });
                },
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
