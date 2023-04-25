import 'package:flutter/material.dart';
import 'package:ninucco/models/battle_info_model.dart';
import 'package:ninucco/services/battle_api_service.dart';
import 'package:percent_indicator/percent_indicator.dart';

class BattleDetailScreen extends StatefulWidget {
  final int memberAId, memberBId, battleId;
  final double ratioA, ratioB;
  final String memberAImage,
      memberBImage,
      question,
      memberANickname,
      memberBNickname;

  const BattleDetailScreen({
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

  @override
  void initState() {
    super.initState();
    battle = BattleApiService.getBattlesById(widget.battleId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppbarWidget(
        titleText: "이 배틀의 상황은?",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 10,
                  child: Image.asset(
                    "assets/images/vs.png",
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Material(
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  flex: 2,
                                  fit: FlexFit.tight,
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(10),
                                        width: 200,
                                        height: 200,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.teal,
                                        ),
                                        child: Image.network(
                                          widget.memberAImage,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Text(widget.memberANickname),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  fit: FlexFit.tight,
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(10),
                                        width: 200,
                                        height: 200,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.amber,
                                        ),
                                        child: Image.network(
                                          widget.memberBImage,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Text(widget.memberBNickname),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Image.asset(
                              'assets/images/vs.png',
                              fit: BoxFit.contain,
                              width: 70,
                              height: 70,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.question,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${widget.memberANickname}이 이기면 ${widget.ratioA}배",
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "${widget.memberBNickname}이 이기면 ${widget.ratioB}배",
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      LinearPercentIndicator(
                        animation: true,
                        animationDuration: 500,
                        lineHeight: 10.0,
                        percent:
                            (widget.ratioA) / (widget.ratioA + widget.ratioB),
                        progressColor: Colors.blue.shade400,
                        backgroundColor: Colors.red.shade400,
                        barRadius: const Radius.elliptical(5, 3),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment(0.8, 1),
                            colors: <Color>[
                              Color(0xffd0d3fe),
                              Color(0xffddccfd),
                              Color(0xffefc9fc),
                              Color(0xfffbc6f4),
                              Color(0xfffac3dc),
                              Color(0xfff8c0c3),
                              Color(0xfff7d1bd),
                              Color(0xfff5e6ba),
                            ],
                            tileMode: TileMode.mirror,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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
  Size get preferredSize => const Size.fromHeight(80);
}
