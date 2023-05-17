import 'package:flutter/material.dart';
import 'package:ninucco/screens/battle/battle_active_screen.dart';
import 'package:ninucco/screens/battle/battle_past_screen.dart';

class BattleScreen extends StatelessWidget {
  const BattleScreen({super.key});

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
    _tabController = TabController(length: 2, vsync: this);
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
        title: const Text('배틀 모아보기'),
        bottom: TabBar(
          indicatorWeight: 2,
          unselectedLabelColor: Colors.black54,
          indicatorColor: const Color(0xff9C9EFE),
          labelColor: Colors.black,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              text: "진행중인 배틀",
            ),
            Tab(
              text: "지난 배틀",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          Center(
            child: BattleActiveScreen(),
          ),
          Center(
            child: BattlePastScreen(),
          ),
        ],
      ),
    );
  }
}
