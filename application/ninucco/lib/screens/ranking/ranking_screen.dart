import 'package:flutter/material.dart';
import 'package:ninucco/screens/ranking/ranking_battle_screen.dart';
import 'package:ninucco/screens/ranking/ranking_elo_screen.dart';
import 'package:ninucco/screens/ranking/ranking_point_screen.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyStatefulWidget();
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  void onTap(String memberId) {
    print(memberId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
        title: const Text('명예의 전당'),
        bottom: TabBar(
          indicatorWeight: 2,
          unselectedLabelColor: Colors.black54,
          indicatorColor: const Color(0xff9C9EFE),
          labelColor: Colors.black,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              text: "배틀",
            ),
            Tab(
              text: "ELO",
            ),
            Tab(
              text: "포인트",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Center(
            child: RankingBattleScreen(),
          ),
          Center(
            child: RankingEloScreen(),
          ),
          Center(
            child: RankingPointScreen(),
          ),
        ],
      ),
    );
  }
}
