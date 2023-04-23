import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FaceScan extends StatefulWidget {
  final RouteSettings settings;
  const FaceScan({super.key, required this.settings});

  @override
  State<FaceScan> createState() => _FaceScanState();
}

class _FaceScanState extends State<FaceScan> {
  File? _image;
  void setImage(path) {
    setState(() {
      if (path == null) {
        _image = null;
      } else {
        _image = File(path);
      }
    });
  }

  Widget showImage() {
    return Container(
        color: const Color(0xffd0cece),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        child: Center(
            child: _image == null
                ? const Text('No image selected.')
                : Image.file(File(_image!.path))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("args.title ${widget.settings.arguments}"),
      ),
      body: Container(
        child: Column(children: [
          showImage(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
          )
        ]),
      ),
    );
  }
}

class CameraButton extends StatefulWidget {
  final Function setImage;
  final String type;

  const CameraButton({
    super.key,
    required this.setImage,
    required this.type,
  });

  @override
  State<CameraButton> createState() => _CameraButtonState();
}

class _CameraButtonState extends State<CameraButton> {
  final picker = ImagePicker();

  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);
    widget.setImage(image?.path);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        getImage(
            widget.type == 'camera' ? ImageSource.camera : ImageSource.gallery);
      },
      child: Stack(
        children: [
          Image.asset(
              'assets/images/scan_items/${widget.type == 'camera' ? 'blue' : 'purple'}_block.png'),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/${widget.type}_icon.png'),
                const Text(
                  "카메라",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
