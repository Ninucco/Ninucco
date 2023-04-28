import 'package:flutter/material.dart';
import 'package:ninucco/utilities/scan_list_data.dart';

class ResultData {
  final int type;
  final String title;
  final String description;
  final String imageUrl;

  ResultData({
    required this.type,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  factory ResultData.fromJson(Map<String, dynamic> json) {
    return ResultData(
      type: json['type'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }
}

class ScanResult extends StatefulWidget {
  final RouteSettings settings;

  const ScanResult({super.key, required this.settings});

  @override
  State<ScanResult> createState() => _ScanResultState();
}

class _ScanResultState extends State<ScanResult> {
  ScanUtility? _scanUtility;
  ResultData _resultData = ResultData(
    type: 0,
    title: 'title',
    description: 'description',
    imageUrl: 'imageUrl',
  );

  @override
  void initState() {
    _resultData = widget.settings.arguments as ResultData;
    _scanUtility = ScanUtility();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_scanUtility!.getScanTitleList[_resultData.type][1]),
      ),
      body: Container(
        child: Column(
          children: [
            Text(_resultData.description),
            Text('${_resultData.type}'),
          ],
        ),
      ),
    );
  }
}
