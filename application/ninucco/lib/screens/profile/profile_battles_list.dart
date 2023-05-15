import 'package:flutter/material.dart';
import 'package:ninucco/models/battle_info_model.dart';
import 'package:ninucco/models/user_detail_model.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ProfileBattlesListArgs {
  final List<Battle> data;
  final String userId;
  final int selectedId;

  ProfileBattlesListArgs({
    required this.data,
    required this.selectedId,
    required this.userId,
  });
}

class ProfileBattlesList extends StatefulWidget {
  final RouteSettings settings;
  const ProfileBattlesList({
    super.key,
    required this.settings,
  });

  @override
  State<ProfileBattlesList> createState() => _ProfileBattlesListState();
}

class _ProfileBattlesListState extends State<ProfileBattlesList> {
  late List<Battle> _resultDataList;
  late int _selectedId;
  late String _userId;
  final ItemScrollController _scrollController = ItemScrollController();

  @override
  void initState() {
    var incomeData = widget.settings.arguments as ProfileBattlesListArgs;
    _selectedId = incomeData.selectedId;
    _resultDataList = incomeData.data;
    _userId = incomeData.userId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ScrollablePositionedList.builder(
        itemScrollController: _scrollController,
        initialScrollIndex: _selectedId,
        itemCount: _resultDataList.length,
        itemBuilder: (context, index) {
          var battleData = _resultDataList[index];
          var isApplicant = battleData.applicantId == _userId;

          var isWin = isApplicant && battleData.result == "APPLICANT" ||
              !isApplicant && battleData.result != "APPLICANT";

          var battleResult = battleData.result == "DRAW"
              ? "DRAW"
              : battleData.result == "PROCEEDING"
                  ? "PROCEEDING"
                  : isWin
                      ? "WIN"
                      : "LOSE";
          Map colorMap = {
            "DRAW": const Color(0xffE4E5E7),
            "WIN": const Color(0xff00fc00),
            "LOSE": const Color.fromARGB(255, 245, 73, 73),
          };

          return Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              left: 12,
              right: 12,
              top: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  battleData.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      children: [
                        Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          width: MediaQuery.of(context).size.width * 0.5 - 18,
                          height: MediaQuery.of(context).size.width * 0.5 - 18,
                          child: Image.network(
                            battleData.applicantUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        battleResult != "PROCEEDING"
                            ? Container(
                                width: MediaQuery.of(context).size.width * 0.5 -
                                    18,
                                height:
                                    MediaQuery.of(context).size.width * 0.5 -
                                        18,
                                decoration: const BoxDecoration(
                                  color: Colors.black38,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),
                              )
                            : const SizedBox(),
                        isApplicant && battleResult != "PROCEEDING"
                            ? Positioned(
                                top: MediaQuery.of(context).size.width / 4,
                                left: MediaQuery.of(context).size.width / 4,
                                child: FractionalTranslation(
                                  translation: const Offset(-0.5, -0.5),
                                  child: Transform.rotate(
                                    angle: -45,
                                    child: Text(
                                      battleResult,
                                      style: TextStyle(
                                        color: colorMap[battleResult],
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox()
                      ],
                    ),
                    Stack(
                      children: [
                        Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          width: MediaQuery.of(context).size.width * 0.5 - 18,
                          height: MediaQuery.of(context).size.width * 0.5 - 18,
                          child: Image.network(
                            battleData.opponentUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        battleResult != "PROCEEDING"
                            ? Container(
                                width: MediaQuery.of(context).size.width * 0.5 -
                                    18,
                                height:
                                    MediaQuery.of(context).size.width * 0.5 -
                                        18,
                                decoration: const BoxDecoration(
                                  color: Colors.black38,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),
                              )
                            : const SizedBox(),
                        !isApplicant && battleResult != "PROCEEDING"
                            ? Positioned(
                                top: MediaQuery.of(context).size.width / 4,
                                left: MediaQuery.of(context).size.width / 4,
                                child: FractionalTranslation(
                                  translation: const Offset(-0.5, -0.5),
                                  child: Transform.rotate(
                                    angle: -45,
                                    child: Text(
                                      battleResult,
                                      style: TextStyle(
                                        color: colorMap[battleResult],
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox()
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: const EdgeInsets.symmetric(vertical: 4),
                      ),
                      onPressed: () {
                        if (battleResult == "PROCEEDING") {
                          Navigator.pushNamed(
                            context,
                            '/BattleDetailScreen',
                            arguments: BattleInfoModel(
                              battleData.battleId,
                              1,
                              2,
                              battleData.applicantUrl,
                              battleData.applicantName,
                              battleData.opponentUrl,
                              battleData.opponentName,
                              battleData.title,
                              battleData.applicantOdds,
                              battleData.opponentOdds,
                            ),
                          );
                        } else {}
                      },
                      child: const Text(
                        "자세히보기",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Divider(
                  height: 2,
                  color: Colors.black,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
