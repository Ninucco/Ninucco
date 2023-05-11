//ScreenB.dart

import 'package:flutter/material.dart';

class ScreenB extends StatelessWidget {
  const ScreenB({super.key, required this.tabIndex});
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("ScreenB")),
        body: Center(
          child: Column(
            children: <Widget>[
              const Text("ScreenB"),
              TextButton(
                onPressed: (() {
                  Navigator.pop(context);
                }),
                child: const Text("Go back"),
              ),
            ],
          ),
        ));
  }
}
