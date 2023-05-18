import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ninucco/models/battle_comment_info_model.dart';
import 'package:ninucco/models/battle_comment_post_model.dart';
import 'package:ninucco/models/battle_info_model.dart';
import 'package:ninucco/models/member_model.dart';
import 'package:ninucco/providers/auth_provider.dart';
import 'package:ninucco/screens/battle/battle_prev_detail_screen.dart';
import 'package:ninucco/services/battle_comment_api_service.dart';
import 'package:ninucco/services/betting_api_service.dart';
import 'package:ninucco/widgets/battle/battle_member_widget.dart';
import 'package:ninucco/widgets/common/my_appbar_widget.dart';
import 'package:provider/provider.dart';

class BattleDetailScreen extends StatefulWidget {
  final RouteSettings settings;
  final FocusNode textFocus = FocusNode();
  BattleDetailScreen({
    super.key,
    required this.settings,
  });

  @override
  State<BattleDetailScreen> createState() => _BattleDetailScreenState();
}

class _BattleDetailScreenState extends State<BattleDetailScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  late BattleInfoModel _resultData;
  bool _resultBetCheck = false;

  MemberModel? me;
  bool inited = false;
  List<BattleCommentInfoModel>? _battleComments;
  Future<void>? _initBattleComment;

  Future<bool> _betCheck(int battleId, String memberId) async {
    return BettingApiService.checkBetting(battleId, memberId);
  }

  void toggleBetCheck() {
    setState(() {
      _resultBetCheck = false;
    });
  }

  Future<void> _initDatas(int id, String userId) async {
    final data = await BattleApiCommentService.fetchBattleComments(id);
    final betData = await _betCheck(_resultData.battleId, userId);

    setState(() {
      _battleComments = data;
      _resultBetCheck = betData;
    });
  }

  @override
  void initState() {
    super.initState();
    _resultData = widget.settings.arguments as BattleInfoModel;
  }

  DateTime dateTime = DateTime.now();

  void handleSubmit({value, me}) {
    setState(() {
      List<int> currentTime = [
        dateTime.year,
        dateTime.month,
        dateTime.day,
        dateTime.hour,
        dateTime.minute,
        dateTime.second,
      ];
      var newComment = BattleCommentInfoModel(
        content: value,
        id: me.id,
        nickname: me!.nickname,
        profileImage: me.url,
        createdAt: currentTime,
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
    me = Provider.of<AuthProvider>(context).member;

    if (inited == false) {
      _initBattleComment = _initDatas(_resultData.battleId, me!.id);
      inited = true;
    }

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
              onTap: () => widget.textFocus.unfocus(),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                width: MediaQuery.of(context).size.width,
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
                          betCheck: _resultBetCheck,
                          toggleBetCheck: toggleBetCheck,
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
                          betCheck: _resultBetCheck,
                          toggleBetCheck: toggleBetCheck,
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
                    // 여기부터 댓글

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
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.send,
                                ),
                                mouseCursor: MaterialStateMouseCursor.clickable,
                                color: Colors.white,
                                tooltip: "댓글 달기",
                                onPressed: () => handleSubmit(
                                  me: me,
                                  value: _textEditingController.value.text,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Comments(
                      initBattleComment: _initBattleComment,
                      battleComments: _battleComments,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
