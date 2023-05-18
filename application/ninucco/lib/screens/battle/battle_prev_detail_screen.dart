import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ninucco/models/battle_comment_info_model.dart';
import 'package:ninucco/models/battle_comment_post_model.dart';
import 'package:ninucco/models/user_detail_model.dart';
import 'package:ninucco/providers/auth_provider.dart';
import 'package:ninucco/screens/profile/profile_battles_list.dart';
import 'package:ninucco/services/battle_comment_api_service.dart';
import 'package:ninucco/widgets/battle/battle_comment_widget.dart';
import 'package:ninucco/widgets/common/my_appbar_widget.dart';
import 'package:provider/provider.dart';
import 'package:wrapped_korean_text/wrapped_korean_text.dart';

class BattlePrevDetailScreen extends StatefulWidget {
  final RouteSettings settings;
  BattlePrevDetailScreen({
    super.key,
    required this.settings,
  });

  final FocusNode textFocus = FocusNode();
  @override
  State<BattlePrevDetailScreen> createState() => _BattlePrevDetailScreenState();
}

class _BattlePrevDetailScreenState extends State<BattlePrevDetailScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  late Battle _battleData;

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
    _battleData = widget.settings.arguments as Battle;
    _initBattleComment = _initDatas(_battleData.battleId);
  }

  @override
  Widget build(BuildContext context) {
    var me = Provider.of<AuthProvider>(context).member;
    var isApplicant = _battleData.applicantId == me!.id;
    var isWin = isApplicant && _battleData.result == "APPLICANT" ||
        !isApplicant && _battleData.result != "APPLICANT";
    var battleResult = _battleData.result == "DRAW"
        ? "DRAW"
        : _battleData.result == "PROCEEDING"
            ? "PROCEEDING"
            : isWin
                ? "WIN"
                : "LOSE";

    if (inited == false) {
      _initBattleComment = _initDatas(_battleData.battleId);
      inited = true;
    }

    return Scaffold(
      appBar: const MyAppbarWidget(
        titleText: "배틀 결과",
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg/bg2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: GestureDetector(
            onTap: () => widget.textFocus.unfocus(),
            child: Column(
              children: [
                WrappedKoreanText(
                  _battleData.title,
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 16),
                BattleCard(
                  battleData: _battleData,
                  battleResult: battleResult,
                  isApplicant: _battleData.applicantId == me.id,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _textEditingController,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (value) {
                    setState(() {
                      var newComment = BattleCommentInfoModel(
                        content: value,
                        id: me.id,
                        nickname: me.nickname,
                        profileImage: me.url,
                      );
                      _battleComments = [newComment] + _battleComments!;
                    });
                    BattleApiCommentService.postBattleComments(
                      BattleCommentPostModel(value, _battleData.battleId),
                      me.id,
                    );
                    _textEditingController.clear();
                  },
                  style: const TextStyle(fontSize: 16),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "댓글입력",
                    suffixIcon: Icon(Icons.send),
                  ),
                ),
                Comments(
                  initBattleComment: _initBattleComment,
                  battleComments: _battleComments,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Comments extends StatelessWidget {
  const Comments({
    super.key,
    required Future<void>? initBattleComment,
    required List<BattleCommentInfoModel>? battleComments,
  })  : _initBattleComment = initBattleComment,
        _battleComments = battleComments;

  final Future<void>? _initBattleComment;
  final List<BattleCommentInfoModel>? _battleComments;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initBattleComment,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return const Text("Loading...");
        } else if (_battleComments == null) {
          return const Text("NO DATA");
        } else {
          return Column(
            children: _battleComments!
                .map(
                  (data) => BattleCommentItem(
                    memberId: data.id,
                    content: data.content,
                    nickname: data.nickname,
                    profileImage: data.profileImage,
                  ),
                )
                .toList(),
          );
        }
      },
    );
  }
}
