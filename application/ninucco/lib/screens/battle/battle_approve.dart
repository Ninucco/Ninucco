import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ninucco/models/user_detail_model.dart';
import 'package:ninucco/widgets/home/camera_button.dart';
import 'package:ninucco/widgets/home/show_image.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as IMG;
import 'package:http_parser/http_parser.dart';

class BattleApprove extends StatefulWidget {
  final RouteSettings settings;

  const BattleApprove({super.key, required this.settings});

  @override
  State<BattleApprove> createState() => _BattleApproveState();
}

class _BattleApproveState extends State<BattleApprove> {
  final picker = ImagePicker();
  File? _image;
  void setImage(path) async {
    setState(() {
      if (path != null) {
        _image = File(path);
      }
    });
  }

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
    File? img = File(image.path);
    img = await _cropImage(imageFile: img);
    if (img == null) return;

    setImage(img.path);
  }

  @override
  Widget build(BuildContext context) {
    var battleData = widget.settings.arguments as Battle;
    return Scaffold(
      appBar: AppBar(
        title: Text(battleData.title),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ShowImage(context: context, image: _image, type: 0),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CameraButton(
                  setImage: setImage,
                  type: 'camera',
                ),
                CameraButton(
                  setImage: setImage,
                  type: 'gallery',
                )
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: BattlerApproveButton(
                image: _image,
                battleData: battleData,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BattlerApproveButton extends StatelessWidget {
  const BattlerApproveButton({
    super.key,
    required this.image,
    required this.battleData,
  });

  final File? image;
  final Battle battleData;

  void approveBattle() async {
    var url = Uri.parse('https://k8a605.p.ssafy.io/api/battle');
    var request = http.MultipartRequest("PATCH", url);

    request.fields['battleId'] = battleData.battleId.toString();

    IMG.Image? img = IMG.decodeImage(image!.readAsBytesSync());
    IMG.Image resizedImg = IMG.copyResize(img!, width: 512, height: 512);

    var multipartFile = http.MultipartFile.fromBytes(
      'opponentImage',
      IMG.encodePng(resizedImg),
      filename: 'resized_image.png',
      contentType: MediaType.parse('image/png'),
    );

    request.files.add(multipartFile);
    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    print(respStr);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (image == null) {
          return;
        } else {
          approveBattle();
          Navigator.pushReplacementNamed(context, "/MyProfile");
        }
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        backgroundColor: image != null ? Colors.green : Colors.grey,
      ),
      child: Text(
        image != null ? "등록하기" : "이미지를 등록해주세요",
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
