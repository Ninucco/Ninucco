import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ninucco/providers/nav_provider.dart';
import 'package:provider/provider.dart';

class FaceScan extends StatefulWidget {
  final RouteSettings settings;
  const FaceScan({super.key, required this.settings});

  @override
  State<FaceScan> createState() => _FaceScanState();
}

class _FaceScanState extends State<FaceScan> {
  File? _image;
  bool _loading = false;
  void setImage(path) {
    setState(() {
      if (path != null) {
        _image = File(path);
        Provider.of<NavProvider>(context, listen: false).hideBottomNav();
      }
    });
  }

  void setLoading(loading) {
    setState(() {
      _loading = loading;
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

  // 화면이 dispose 될 때 bottom Nav 를 다시 그림
  late NavProvider _navProvider;
  @override
  void didChangeDependencies() {
    _navProvider = Provider.of<NavProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _navProvider.showBottomNav());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("args.title ${widget.settings.arguments}"),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.amber,
        ),
        child: Stack(
          children: [
            if (_image != null)
              SubmitButton(
                  loading: _loading, setLoading: setLoading, context: context),
            Column(
              children: [
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
                ),
              ],
            ),
            if (_loading)
              Positioned.fill(
                  child: Container(
                decoration: const BoxDecoration(color: Colors.black38),
                child: const Text("Loading..."),
              ))
          ],
        ),
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  final bool loading;
  final Function setLoading;
  final BuildContext context;
  const SubmitButton({
    super.key,
    required this.loading,
    required this.setLoading,
    required this.context,
  });

  void handleSubmit() async {
    if (loading) {
      return;
    }
    setLoading(true);
    Future.delayed(const Duration(milliseconds: 1500), () {
      setLoading(false);
      Navigator.pushNamed(context, '/ScanResult');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: MediaQuery.of(context).size.width,
      height: 60,
      right: 0,
      bottom: 0,
      child: ElevatedButton(
        onPressed: handleSubmit,
        child: const Text("SUBMIT"),
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
