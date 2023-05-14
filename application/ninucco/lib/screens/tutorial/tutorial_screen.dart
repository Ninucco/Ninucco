import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ninucco/providers/tutorial_provider.dart';
import 'package:ninucco/utilities/tutorial_image_info.dart';
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
      body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/bg/bg.png'),
            fit: BoxFit.cover,
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 180.0),
              const TutorialCarousel(),
              const SizedBox(height: 40.0),
              ElevatedButton(
                  onPressed: () => tutorialProvider.setIsPassTutorial(true),
                  child: const Text('ninucco 시작하기')),
            ],
          )),
    );
  }
}

class TutorialCarousel extends StatefulWidget {
  const TutorialCarousel({super.key});

  @override
  State<TutorialCarousel> createState() => _TutorialCarouselState();
}

class _TutorialCarouselState extends State<TutorialCarousel> {
  TutorialImages? _tutorialImages;

  @override
  void initState() {
    _tutorialImages = TutorialImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 1,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
      ),
      items: _tutorialImages!.getTutorialImagePaths
          .asMap()
          .map((index, imagePath) {
            return MapEntry(
              index,
              Column(
                children: [
                  Expanded(
                    child: Image.asset(
                      imagePath,
                    ),
                  ),
                  const SizedBox(height: 1.0),
                  Text(
                    _tutorialImages!.getGuideTitle[index],
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Column(
                    children: _tutorialImages!.getGuideMessage[index]
                        .map((message) => Text(
                              message,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            );
          })
          .values
          .toList(),
    );
  }
}
