import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ninucco/models/battle_comment_info_model.dart';
import 'package:ninucco/models/battle_comment_post_model.dart';
import 'package:ninucco/models/battle_info_model.dart';
import 'package:ninucco/providers/auth_provider.dart';
import 'package:ninucco/screens/battle/battle_prev_detail_screen.dart';
import 'package:ninucco/services/battle_comment_api_service.dart';
import 'package:ninucco/widgets/battle/battle_past_member_widget.dart';
import 'package:ninucco/widgets/common/my_appbar_widget.dart';
import 'package:provider/provider.dart';

class BattlePastDetailScreen extends StatefulWidget {
  final RouteSettings settings;
  final FocusNode textFocus = FocusNode();
  BattlePastDetailScreen({
    super.key,
    required this.settings,
  });

  @override
  State<BattlePastDetailScreen> createState() => _BattlePastDetailScreenState();
}

class _BattlePastDetailScreenState extends State<BattlePastDetailScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  late BattleInfoModel _resultData;

  bool inited = false;
  List<BattleCommentInfoModel>? _battleComments;
  Future<void>? _initBattleComment;

  Future<void> _initDatas(int id) async {
    final data = await BattleApiCommentService.fetchBattleComments(id);
    setState(() {
      _battleComments = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _resultData = widget.settings.arguments as BattleInfoModel;
    _initBattleComment = _initDatas(_resultData.battleId);
  }

  void handleSubmit({value, me}) {
    setState(() {
      var newComment = BattleCommentInfoModel(
        content: value,
        id: me.id,
        nickname: me!.nickname,
        profileImage: me.url,
      );
      _battleComments = [newComment] + _battleComments!;
    });
    BattleApiCommentService.postBattleComments(
      BattleCommentPostModel(value, _resultData.battleId),
      me!.id,
    );
    _textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    var me = Provider.of<AuthProvider>(context).member;

    if (inited == false) {
      _initBattleComment = _initDatas(_resultData.battleId);
      inited = true;
    }

    return Scaffold(
      appBar: const MyAppbarWidget(
        titleText: "지난 배틀 다시보기",
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
              onTap: () => widget.textFocus.unfocus(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
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
                                BattlePastMemberWidget(
                                  type: "APPLICANT",
                                  battleId: _resultData.battleId,
                                  memberId: _resultData.memberAId,
                                  nickname: _resultData.memberANickname,
                                  profileImage: _resultData.memberAImage,
                                  ratio: _resultData.ratioA,
                                  result: _resultData.result,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                BattlePastMemberWidget(
                                  type: "OPPONENT",
                                  battleId: _resultData.battleId,
                                  memberId: _resultData.memberBId,
                                  nickname: _resultData.memberBNickname,
                                  profileImage: _resultData.memberBImage,
                                  ratio: _resultData.ratioB,
                                  result: _resultData.result,
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
                                    textInputAction: TextInputAction.done,
                                    onFieldSubmitted: (value) => handleSubmit(
                                      me: me,
                                      value: _textEditingController.value.text,
                                    ),
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
                                        onPressed: () => handleSubmit(
                                          me: me,
                                          value:
                                              _textEditingController.value.text,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Comments(
                              initBattleComment: _initBattleComment,
                              battleComments: _battleComments,
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
