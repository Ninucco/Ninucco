import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ninucco/models/battle_comment_info_model.dart';
import 'package:ninucco/models/battle_info_model.dart';
import 'package:ninucco/services/battle_api_service.dart';
import 'package:ninucco/services/battle_comment_api_service.dart';
import 'package:ninucco/widgets/battle/battle_comment_widget.dart';
import 'package:ninucco/widgets/battle/battle_member_widget.dart';
import 'package:ninucco/widgets/common/my_appbar_widget.dart';

class BattleDetailScreen extends StatefulWidget {
  final int memberAId, memberBId, battleId;
  final double ratioA, ratioB;
  final String memberAImage,
      memberBImage,
      question,
      memberANickname,
      memberBNickname;
  FocusNode textFocus = FocusNode();

  BattleDetailScreen({
    super.key,
    required this.battleId,
    required this.memberAId,
    required this.memberBId,
    required this.ratioA,
    required this.ratioB,
    required this.memberAImage,
    required this.memberBImage,
    required this.memberANickname,
    required this.memberBNickname,
    required this.question,
  });

  @override
  State<BattleDetailScreen> createState() => _BattleDetailScreenState();
}

class _BattleDetailScreenState extends State<BattleDetailScreen> {
  late Future<BattleInfoModel> battle;
  late Stream<List<BattleCommentInfoModel>> battleComments;
  final TextEditingController _textEditingController = TextEditingController();
  final StreamController _streamController = StreamController();

  @override
  void initState() {
    super.initState();
    battle = BattleApiService.getBattlesById(widget.battleId);
    battleComments = BattleApiCommentService.getBattleComments(widget.battleId);
    _streamController.add(battleComments);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppbarWidget(
        titleText: "이 배틀의 상황은?",
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            widget.textFocus.unfocus();
          },
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          widget.question,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            BattleMemberWidget(
                              memberId: widget.memberAId,
                              nickname: widget.memberANickname,
                              profileImage: widget.memberAImage,
                              ratio: widget.ratioA,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            BattleMemberWidget(
                              memberId: widget.memberBId,
                              nickname: widget.memberBNickname,
                              profileImage: widget.memberBImage,
                              ratio: widget.ratioA,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Row(
                          children: [
                            Text(
                              "댓글",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // 댓글 쓰기
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              flex: 4,
                              child: TextFormField(
                                focusNode: widget.textFocus,
                                controller: _textEditingController,
                                decoration: const InputDecoration(
                                  hintText: "댓글을 입력하세요..",
                                ),
                                cursorColor: const Color(0xff9C9EFE),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Container(
                                width: 50,
                                height: 50,
                                margin: const EdgeInsets.all(5),
                                child: Ink(
                                  decoration: ShapeDecoration(
                                    color: const Color(0xff9C9EFE),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                  ),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.send,
                                    ),
                                    mouseCursor:
                                        MaterialStateMouseCursor.clickable,
                                    color: Colors.white,
                                    tooltip: "댓글 달기",
                                    onPressed: () {
                                      setState(
                                        () {
                                          battleComments =
                                              BattleApiCommentService
                                                  .getBattleComments(
                                                      widget.battleId);
                                          _textEditingController
                                              .notifyListeners();
                                          _streamController.add(battleComments);
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        (_textEditingController.value.text.isEmpty)
                            ? const SizedBox(height: 0)
                            : BattleCommentItem(
                                id: 1,
                                profileImage:
                                    "https://hips.hearstapps.com/hmg-prod/images/dog-puppy-on-garden-royalty-free-image-1586966191.jpg?crop=0.752xw:1.00xh;0.175xw,0&resize=1200:*",
                                nickname: "언제봐도 사랑스러운 코코짱",
                                content: _textEditingController.value.text,
                              ),
                        StreamBuilder(
                          stream: battleComments,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: makeList(snapshot),
                                  ),
                                ],
                              );
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                color: Colors.pink.shade200,
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 50,
                        )
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

  ListView makeList(AsyncSnapshot<List<BattleCommentInfoModel>> snapshot) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        var battleComment = snapshot.data![index];
        return BattleCommentItem(
          id: battleComment.id,
          profileImage: battleComment.profileImage,
          nickname: battleComment.nickname,
          content: battleComment.content,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 40),
    );
  }
}
