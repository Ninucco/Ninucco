import 'dart:io';

import 'package:flutter/material.dart';

class ShowImage extends StatelessWidget {
  const ShowImage({
    super.key,
    required this.context,
    required File? image,
    required this.type,
  }) : _image = image;

  final BuildContext context;
  final File? _image;
  final int type;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      width: MediaQuery.of(context).size.width - 64,
      height: MediaQuery.of(context).size.width - 64,
      child: Expanded(
        child: AspectRatio(
          aspectRatio: 1,
          child: _image == null
              ? Image.asset(
                  'assets/images/scan_items/no_img_${type + 1}.png',
                  fit: BoxFit.cover,
                )
              : Image.file(
                  File(_image!.path),
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}
