import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Image.asset(
              'assets/images/scan_items/${widget.type == 'camera' ? 'blue' : 'purple'}_block.png',
              width: MediaQuery.of(context).size.width * 0.5 - 40,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/${widget.type}_icon.png'),
                Text(
                  widget.type == 'camera' ? '카메라' : '갤러리',
                  style: const TextStyle(
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
