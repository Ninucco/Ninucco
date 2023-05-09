import 'package:flutter/material.dart';
import 'package:ninucco/screens/home/scan_result.dart';
import 'package:ninucco/utilities/scan_list_data.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ProfileScanResultsArgs {
  final List<ResultData> data;
  final String selectedId;

  ProfileScanResultsArgs({
    required this.data,
    required this.selectedId,
  });
}

class ProfileScanResult extends StatefulWidget {
  final RouteSettings settings;
  const ProfileScanResult({
    super.key,
    required this.settings,
  });

  @override
  State<ProfileScanResult> createState() => _ProfileScanResultState();
}

class _ProfileScanResultState extends State<ProfileScanResult> {
  ScanUtility? _scanUtility;
  late List<ResultData> _resultDataList;
  late String _selectedId;
  final ItemScrollController _scrollController = ItemScrollController();

  @override
  void initState() {
    // TODO: implement initState

    var incomeData = widget.settings.arguments as ProfileScanResultsArgs;
    _selectedId = incomeData.selectedId;
    _resultDataList = incomeData.data;
    _scanUtility = ScanUtility();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text("hello world $_selectedId"),
    );
  }
}
