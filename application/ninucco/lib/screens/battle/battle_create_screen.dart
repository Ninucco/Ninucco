import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ninucco/models/battle_create_model.dart';
import 'package:ninucco/providers/auth_provider.dart';
import 'package:ninucco/utilities/battle_utils.dart';
import 'package:ninucco/widgets/common/my_appbar_widget.dart';
import 'package:provider/provider.dart';

class BattleCreateScreen extends StatefulWidget {
  const BattleCreateScreen({super.key});

  @override
  State<BattleCreateScreen> createState() => _BattleCreateScreenState();
}

class _BattleCreateScreenState extends State<BattleCreateScreen> {
  String? categoryValue;
  File? _image;

  final picker = ImagePicker();

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      compressFormat: ImageCompressFormat.png,
    );
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);
    if (image == null) return;

    File? croppedImage = File(image.path);
    croppedImage = await _cropImage(imageFile: croppedImage);
    if (croppedImage == null) return;

    setState(() {
      if (croppedImage != null) {
        _image = File(croppedImage.path);
      }
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
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    bool isOk = categoryValue != null && _image != null;
    final battleQuestions = BattleUtil().getBattleQuestions as List<String>;

    return Scaffold(
      appBar: const MyAppbarWidget(
        titleText: "배틀 생성하기",
      ),
      body: Container(
        height:
            MediaQuery.of(context).size.height - AppBar().preferredSize.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg/bg3.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
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
                      dropdownMenuEntries: battleQuestions
                          .map((data) =>
                              DropdownMenuEntry(value: data, label: data))
                          .toList(),
                      onSelected: (String? selectedQuestion) {
                        setState(() => categoryValue = selectedQuestion);
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
                    backgroundColor: isOk ? Colors.black : Colors.grey,
                    shadowColor: Colors.black45,
                  ),
                  child: const Text(
                    '배틀 생성하기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                  onPressed: () => {
                    if (isOk)
                      {
                        Navigator.pushNamed(
                          context,
                          '/BattleCreateDetailScreen',
                          arguments: BattleCreateModel(
                              authProvider.member!.id,
                              _image!,
                              authProvider.member!.nickname,
                              categoryValue!),
                        ),
                      }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
