import 'package:flutter/material.dart';
import 'package:ninucco/models/user_detail_model.dart';
import 'package:ninucco/widgets/battle/battle_item_widget.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ProfileBattlesListArgs {
  final List<Battle> data;
  final int selectedId;

  ProfileBattlesListArgs({
    required this.data,
    required this.selectedId,
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
  final ItemScrollController _scrollController = ItemScrollController();

  @override
  void initState() {
    var incomeData = widget.settings.arguments as ProfileBattlesListArgs;
    _selectedId = incomeData.selectedId;
    _resultDataList = incomeData.data;
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
          return BattleItem(
            memberANickname: battleData.applicantName,
            memberBNickname: battleData.opponentName,
            memberAId: 1,
            memberAImage: battleData.applicantUrl,
            memberBId: 2,
            memberBImage: battleData.opponentUrl,
            battleId: battleData.battleId,
            question: battleData.title,
            ratioA: battleData.applicantOdds,
            ratioB: battleData.opponentOdds,
          );
        },
      ),
    );
  }
}
