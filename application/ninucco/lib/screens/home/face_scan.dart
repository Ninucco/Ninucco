import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ninucco/providers/nav_provider.dart';
import 'package:ninucco/utilities/scan_list_data.dart';
import 'package:ninucco/widgets/home/camera_button.dart';
import 'package:ninucco/widgets/home/show_image.dart';
import 'package:ninucco/widgets/home/submit_button.dart';
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
  String typeName = '';
  File? _image;
  bool _loading = false;

  @override
  void initState() {
    type = widget.settings.arguments as int;
    typeName = _scanUtility.getTypeList[type];
    super.initState();
  }

  void setImage(path) async {
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
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 96, right: 32, bottom: 32, left: 32),
                child: Column(
                  children: [
                    ShowImage(context: context, image: _image, type: type),
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
                        context: context,
                        type: type,
                        image: _image!,
                      ),
                  ],
                ),
              ),
              if (_loading)
                Positioned(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  top: 0,
                  left: 0,
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Image.asset('assets/images/loading_1.gif'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
