import 'dart:io';

import 'package:flutter/material.dart';

class BattleCreateItem extends StatelessWidget {
  final int memberAId;
  final String question, memberANickname, memberBNickname;
  final File memberAImage;

  const BattleCreateItem({
    super.key,
    required this.memberAId,
    required this.memberAImage,
    required this.question,
    required this.memberANickname,
    required this.memberBNickname,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Material(
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: Column(
                            children: [
                              Container(
                                width: 150,
                                height: 150,
                                margin: const EdgeInsets.all(10),
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.teal,
                                ),
                                child: Image.file(
                                  memberAImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(memberANickname),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: Column(
                            children: [
                              Container(
                                width: 150,
                                height: 150,
                                margin: const EdgeInsets.all(10),
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.amber,
                                ),
                                child: Image.asset(
                                  "assets/images/anonymous.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(memberBNickname),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Image.asset(
                      'assets/images/vs.png',
                      fit: BoxFit.contain,
                      width: 70,
                      height: 70,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                question,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
