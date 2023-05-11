import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ninucco/providers/auth_provider.dart';
import 'package:ninucco/screens/home/scan_result.dart';
import 'package:image/image.dart' as IMG;
import 'package:http_parser/http_parser.dart';
import 'package:ninucco/utilities/scan_list_data.dart';
import 'package:provider/provider.dart';

class SubmitButton extends StatefulWidget {
  final bool loading;
  final Function setLoading;
  final BuildContext context;
  final int type;
  final File image;

  const SubmitButton({
    super.key,
    required this.loading,
    required this.setLoading,
    required this.context,
    required this.type,
    required this.image,
  });

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  final _scanUtility = ScanUtility();
  String typeName = '';

  @override
  void initState() {
    typeName = _scanUtility.getTypeList[widget.type];
    super.initState();
  }

  Future fetchScanResult(String userId) async {
    var url = Uri.parse('https://k8a605.p.ssafy.io/api/face');
    var request = http.MultipartRequest("POST", url);

    request.fields['memberId'] = userId;
    request.fields['modelType'] = typeName;

    IMG.Image? img = IMG.decodeImage(widget.image.readAsBytesSync());
    IMG.Image resizedImg = IMG.copyResize(img!, width: 512, height: 512);

    var multipartFile = http.MultipartFile.fromBytes(
      'img',
      IMG.encodePng(resizedImg),
      filename: 'resized_image.png',
      contentType: MediaType.parse('image/png'),
    );

    request.files.add(multipartFile);

    var response = await request.send();
    final respStr = await response.stream.bytesToString();

    var jsonData = jsonDecode(respStr)['data'];
    var list = jsonData['resultList'] as List;
    var analyticItemList = list.map((i) => AnalyticItem.fromJson(i)).toList();
    return ResultData(
      type: widget.type,
      resultTitle: jsonData['resultTitle'],
      resultDescription: jsonData['resultDescription'],
      imgUrl: jsonData['imgUrl'],
      resultPercentages: analyticItemList,
    );
  }

  void handleSubmit(String memberId) async {
    if (widget.loading) {
      return;
    }
    widget.setLoading(true);
    Navigator.pushNamed(widget.context, '/ScanResult',
        arguments: await fetchScanResult(memberId));
    widget.setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    var me = authProvider.member;
    return Column(
      children: [
        const SizedBox(height: 32),
        GestureDetector(
          onTap: () {
            authProvider.setUpdate();
            handleSubmit(me!.id);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            width: double.infinity,
            child: Text(
              "$typeName 분석하기",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
