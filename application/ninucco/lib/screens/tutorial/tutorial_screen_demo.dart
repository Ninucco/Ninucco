import 'package:flutter/material.dart';
import 'package:ninucco/providers/tutorial_provider.dart';
import 'package:provider/provider.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  @override
  Widget build(BuildContext context) {
    TutorialProvider tutorialProvider = Provider.of<TutorialProvider>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '튜토리얼 페이지',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 80,
              ),
            ),
            ElevatedButton(
                onPressed: () => tutorialProvider.setIsPassTutorial(true),
                child: const Text('튜토리얼 끝')),
          ],
        ),
      ),
    );
  }
}
