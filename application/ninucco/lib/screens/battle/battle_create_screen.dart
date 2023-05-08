import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ninucco/screens/battle/battle_create_detail_screen.dart';
import 'package:ninucco/widgets/common/my_appbar_widget.dart';

class BattleCreateScreen extends StatefulWidget {
  const BattleCreateScreen({super.key});

  @override
  State<BattleCreateScreen> createState() => _BattleCreateScreenState();
}

class _BattleCreateScreenState extends State<BattleCreateScreen> {
  String? categoryValue;
  File? _image;
  final picker = ImagePicker();

  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);

    setState(() {
      _image = File(image!.path);
    });
  }

  Widget showImage() {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.75,
      width: MediaQuery.of(context).size.width * 0.75,
      child: ElevatedButton(
        onPressed: () {
          getImage(ImageSource.gallery);
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: const Color.fromARGB(255, 127, 129, 250),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: _image == null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: Icon(
                            size: MediaQuery.of(context).size.width * 0.3,
                            Icons.photo,
                            color: Colors.white,
                          ),
                        ),
                        const Text("이미지를 업로드해주세요")
                      ],
                    )
                  : Container(
                      height: MediaQuery.of(context).size.width * 0.75,
                      width: MediaQuery.of(context).size.width * 0.75,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18.0)),
                      clipBehavior: Clip.hardEdge,
                      child: Image.file(
                        File(
                          _image!.path,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppbarWidget(
        titleText: "배틀 생성하기",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent, width: 0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 8), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: DropdownMenu(
                    menuStyle: MenuStyle(
                        side: MaterialStateBorderSide.resolveWith(
                            (states) => null)),
                    inputDecorationTheme: const InputDecorationTheme(
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius:
                              BorderRadius.all(Radius.circular(18.0))),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    label: const Text(
                      '배틀 질문',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                      ),
                    ),
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(
                          value: "누가 더 백엔드 개발자처럼 생겼나요?",
                          label: "누가 더 백엔드 개발자처럼 생겼나요?"),
                      DropdownMenuEntry(
                          value: "누가 더 피자를 좋아할 것처럼 생겼나요?",
                          label: "누가 더 피자를 좋아할 것처럼 생겼나요?"),
                      DropdownMenuEntry(
                          value: "누가 더 빨리 부자가 될 것 같나요?",
                          label: "누가 더 빨리 부자가 될 것 같나요?"),
                    ],
                    onSelected: (String? selectedQuestion) {
                      setState(
                        () {
                          categoryValue = selectedQuestion;
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    color: Color.fromARGB(255, 127, 129, 250),
                  ),
                  child: showImage(),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              width: MediaQuery.of(context).size.width * 0.75,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  backgroundColor: Colors.black,
                  shadowColor: Colors.black45,
                ),
                child: const Text(
                  'Create Battle',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BattleCreateDetailWidget(
                        memberAId: 1,
                        memberAImage:
                            "https://pbs.twimg.com/media/E_-EPpcVUAcXgmU.jpg",
                        memberANickname: "실험중입니당",
                        question: categoryValue!,
                      ),
                    ),
                  ),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
