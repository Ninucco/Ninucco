import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:ninucco/screens/home/scan_result.dart';

class SubmitButton extends StatelessWidget {
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

  Future fetchScanResult() async {
    String base64url = base64Encode(image.readAsBytesSync());
    print(base64url);
    final response =
        await http.get(Uri.parse('https://k8a605.p.ssafy.io/api/face/dummy'));
    var json = jsonDecode(response.body)['data'];
    var list = json['resultPercentages'] as List;
    List<AnalyticItem> analyticItemList =
        list.map((i) => AnalyticItem.fromJson(i)).toList();
    return ResultData(
      type: type,
      resultTitle: json['resultTitle'],
      resultDescription: json['resultDescription'],
      imgUrl: json['imgUrl'],
      resultPercentages: analyticItemList,
    );
  }

  void handleSubmit() async {
    if (loading) {
      return;
    }
    setLoading(true);
    await fetchScanResult();
    // Navigator.pushNamed(context, '/ScanResult',
    //     arguments: await fetchScanResult());
    setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 32),
        GestureDetector(
          onTap: handleSubmit,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            width: double.infinity,
            child: const Text(
              "분석하기",
              textAlign: TextAlign.center,
              style: TextStyle(
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
