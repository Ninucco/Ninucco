import 'package:flutter/material.dart';

class ScreenA extends StatelessWidget {
  const ScreenA({super.key, required this.tabIndex});
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("ScreenA")),
        body: Center(
          child: Column(children: [
            Text("from tab: ${tabIndex.toString()}"),
            TextButton(
              child: const Text("Go to ScreenB"),
              onPressed: () {
                Navigator.pushNamed(context, '/ScreenB');
              },
            )
          ]),
        ));
  }
}
