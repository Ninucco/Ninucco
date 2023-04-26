import 'package:flutter/material.dart';
import 'package:ninucco/screens/login/login_google_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  // final Future<List<UserRankInfoModel>> userRanks =
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyStatefulWidget(),
    );
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
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
        title: const Text('Sign In'),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Center(
            child: LoginGoogleScreen(),
          ),
        ],
      ),
    );
  }
}
