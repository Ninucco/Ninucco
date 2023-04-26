import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ninucco/providers/nav_provider.dart';
import 'package:ninucco/utilities/scan_list_data.dart';
import 'package:provider/provider.dart';
import 'package:wrapped_korean_text/wrapped_korean_text.dart';

class FaceScan extends StatefulWidget {
  final RouteSettings settings;
  const FaceScan({super.key, required this.settings});

  @override
  State<FaceScan> createState() => _FaceScanState();
}

class _FaceScanState extends State<FaceScan> {
  final ScanUtility _scanUtility = ScanUtility();
  int type = 0;
  File? _image;
  bool _loading = false;

  @override
  void initState() {
    type = widget.settings.arguments as int;
    super.initState();
  }

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined,
              color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/bg/bg.png'),
            fit: BoxFit.fill,
          )),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 96, right: 32, bottom: 32, left: 32),
            child: Stack(
              children: [
                Column(
                  children: [
                    showImage(),
                    const SizedBox(height: 32),
                    Text(
                      _scanUtility.getScanTitleList[type].join(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 6.0,
                            color: Colors.black26,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    WrappedKoreanText(
                      _scanUtility.getScanDescription[type],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black87,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 32),
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
                    if (_image != null)
                      SubmitButton(
                          loading: _loading,
                          setLoading: setLoading,
                          context: context),
                  ],
                ),
                if (_loading)
                  Container(
                    decoration: const BoxDecoration(color: Colors.black38),
                    child: const Text("Loading..."),
                  ),
              ],
            ),
          ),
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
    print("분석 시작");
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
