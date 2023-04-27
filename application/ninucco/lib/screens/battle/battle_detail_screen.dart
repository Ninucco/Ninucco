import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ninucco/models/battle_comment_info_model.dart';
import 'package:ninucco/models/battle_info_model.dart';
import 'package:ninucco/services/battle_api_service.dart';
import 'package:ninucco/services/battle_comment_api_service.dart';
import 'package:ninucco/widgets/battle/battle_comment_widget.dart';

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
  late Future<List<BattleCommentInfoModel>> battleComments;
  final TextEditingController _textEditingController = TextEditingController();
  final StreamController _streamController = StreamController();
  // FocusNode textFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    battle = BattleApiService.getBattlesById(widget.battleId);
    battleComments = BattleApiCommentService.getBattleComments(widget.battleId);
  }

  @override
  Widget build(BuildContext context) {
    List<String> splitA = widget.memberANickname.split(' ');
    List<String> splitB = widget.memberBNickname.split(' ');
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
                            Row(
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                      right: 10,
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.teal,
                                    ),
                                    child: Image.network(
                                      widget.memberAImage,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        splitA[0],
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
                                        "${splitA[1]} ${splitA[2]}",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          const Text(
                                            "이기면  ",
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                            textAlign: TextAlign.right,
                                          ),
                                          Text(
                                            " ${widget.ratioA}배",
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: const [
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                                elevation: 5,
                                                backgroundColor: Colors.black,
                                                shadowColor: Colors.black45),
                                            child: const Text(
                                              "여기에 베팅하기",
                                              style: TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                      right: 10,
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.amber,
                                    ),
                                    child: Image.network(
                                      widget.memberAImage,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        splitB[0],
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
                                        "${splitB[1]} ${splitB[2]}",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          const Text(
                                            "이기면  ",
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                            textAlign: TextAlign.right,
                                          ),
                                          Text(
                                            " ${widget.ratioB}배",
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: const [
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                                elevation: 5,
                                                backgroundColor: Colors.black,
                                                shadowColor: Colors.black45),
                                            child: const Text(
                                              "여기에 베팅하기",
                                              style: TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: const [
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
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: ElevatedButton(
                                  style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll<Color>(
                                      Color(0xff9C9EFE),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(
                                      () {
                                        _textEditingController
                                            .notifyListeners();
                                      },
                                    );
                                  },
                                  child: const Icon(
                                    Icons.send,
                                    size: 20,
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
                            ? const Text("")
                            : BattleCommentItem(
                                id: 1,
                                profileImage:
                                    "https://hips.hearstapps.com/hmg-prod/images/dog-puppy-on-garden-royalty-free-image-1586966191.jpg?crop=0.752xw:1.00xh;0.175xw,0&resize=1200:*",
                                nickname: "언제봐도 사랑스러운 코코짱",
                                content: _textEditingController.value.text,
                              ),
                        FutureBuilder(
                          future: battleComments,
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

class MyAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;

  const MyAppbarWidget({
    super.key,
    required this.titleText,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon:
            const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Text(
        titleText,
      ),
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
