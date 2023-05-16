import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ninucco/models/battle_comment_info_model.dart';
import 'package:ninucco/models/battle_comment_post_model.dart';
import 'package:ninucco/models/battle_info_model.dart';
import 'package:ninucco/providers/auth_provider.dart';
import 'package:ninucco/services/battle_api_service.dart';
import 'package:ninucco/services/battle_comment_api_service.dart';
import 'package:ninucco/widgets/battle/battle_comment_widget.dart';
import 'package:ninucco/widgets/battle/battle_member_widget.dart';
import 'package:ninucco/widgets/common/my_appbar_widget.dart';
import 'package:provider/provider.dart';

class BattleDetailScreen extends StatefulWidget {
  final RouteSettings settings;
  BattleDetailScreen({
    super.key,
    required this.settings,
  });

  FocusNode textFocus = FocusNode();

  @override
  State<BattleDetailScreen> createState() => _BattleDetailScreenState();
}

class _BattleDetailScreenState extends State<BattleDetailScreen> {
  late Future<BattleInfoModel> battle;
  late Stream<List<BattleCommentInfoModel>> battleComments;
  final TextEditingController _textEditingController = TextEditingController();
  late BattleInfoModel _resultData;

  @override
  void initState() {
    super.initState();
    _resultData = widget.settings.arguments as BattleInfoModel;
    battle = BattleApiService.getBattlesById(_resultData.battleId);
    battleComments =
        BattleApiCommentService.getBattleComments(_resultData.battleId);
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: const MyAppbarWidget(
        titleText: "이 배틀의 상황은?",
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg/bg2.png',
              repeat: ImageRepeat.repeat,
              fit: BoxFit.fitWidth,
            ),
          ),
          SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                              _resultData.question,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                BattleMemberWidget(
                                  type: "APPLICANT",
                                  battleId: _resultData.battleId,
                                  memberId: _resultData.memberAId,
                                  nickname: _resultData.memberANickname,
                                  profileImage: _resultData.memberAImage,
                                  ratio: _resultData.ratioA,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                BattleMemberWidget(
                                  type: "OPPONENT",
                                  battleId: _resultData.battleId,
                                  memberId: _resultData.memberBId,
                                  nickname: _resultData.memberBNickname,
                                  profileImage: _resultData.memberBImage,
                                  ratio: _resultData.ratioB,
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
                                    onFieldSubmitted: (value) => {
                                      _textEditingController.notifyListeners(),
                                      BattleApiCommentService
                                          .postBattleComments(
                                              BattleCommentPostModel(
                                                _textEditingController
                                                    .value.text,
                                                _resultData.battleId,
                                              ),
                                              authProvider.member!.id),
                                      _textEditingController.clear(),
                                      setState(
                                        () {
                                          battleComments =
                                              BattleApiCommentService
                                                  .getBattleComments(
                                                      _resultData.battleId);
                                        },
                                      ),
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode()),
                                    },
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
                                          borderRadius:
                                              BorderRadius.circular(18),
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
                                              _textEditingController
                                                  .notifyListeners();
                                                  if(_textEditingController.value.text != ""){
                                              BattleApiCommentService
                                                  .postBattleComments(
                                                      BattleCommentPostModel(
                                                          _textEditingController
                                                              .value.text,
                                                          _resultData.battleId),
                                                      authProvider.member!.id);
                                              _textEditingController.clear();
                                                  

                                              setState(
                                                () {
                                                  print("I'm listening~~");
                                                  battleComments =
                                                      BattleApiCommentService
                                                          .getBattleComments(
                                                              _resultData
                                                                  .battleId);
                                                },
                                              );
                                                  };
                                              FocusScope.of(context)
                                                  .requestFocus(FocusNode());
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
        ],
      ),
    );
  }
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
