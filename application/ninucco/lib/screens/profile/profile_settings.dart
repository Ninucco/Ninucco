import 'package:flutter/material.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("프로필 설정")),
      body: Container(
        child: const SingleChildScrollView(
            child: Column(
          children: [
            Text("프로필 설정"),
            Text("로그아웃"),
            Text("계정약관"),
          ],
        )),
      ),
    );
  }
}
