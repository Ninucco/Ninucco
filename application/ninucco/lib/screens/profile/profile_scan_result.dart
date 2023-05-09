import 'package:flutter/material.dart';
import 'package:ninucco/screens/home/scan_result.dart';
import 'package:ninucco/utilities/scan_list_data.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProfileScanResultsArgs {
  final List<ResultData> data;
  final int selectedId;

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
  late int _selectedId;
  late ScrollController _controller;

  @override
  void initState() {
    var incomeData = widget.settings.arguments as ProfileScanResultsArgs;
    _selectedId = incomeData.selectedId;
    _resultDataList = incomeData.data;
    _scanUtility = ScanUtility();
    _controller = ScrollController(initialScrollOffset: _selectedId * 500);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "분석결과",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: ListView.builder(
        controller: _controller,
        itemCount: _resultDataList.length,
        itemBuilder: (context, index) {
          return SizedBox(
            child: Column(
              children: [
                Image.network(
                  _resultDataList[index].imgUrl,
                  fit: BoxFit.fitWidth,
                ),
                ExpansionTile(
                  title: Text(_resultDataList[index].resultTitle),
                  childrenPadding:
                      const EdgeInsets.only(left: 12, right: 12, bottom: 16),
                  children: [
                    for (var item in _resultDataList[index].resultPercentages)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 64,
                            height: 24,
                            child: FittedBox(
                              alignment: Alignment.centerLeft,
                              child: Text(item.keyword),
                            ),
                          ),
                          LinearPercentIndicator(
                            animation: true,
                            lineHeight: 12.0,
                            animationDuration: 2000,
                            width: MediaQuery.sizeOf(context).width - 128,
                            percent: item.value,
                            barRadius: const Radius.circular(12),
                            backgroundColor: Colors.black12,
                            linearGradient: LinearGradient(colors: [
                              Colors.pink.shade500,
                              Colors.pink.shade300,
                              Colors.pink.shade100,
                            ]),
                            trailing: SizedBox(
                              width: 16,
                              height: 24,
                              child: FittedBox(
                                alignment: Alignment.centerLeft,
                                child: Text("${(item.value * 100).round()}"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    const Divider(color: Colors.black54, height: 48),
                    Text(
                      _resultDataList[index].resultDescription,
                      style: const TextStyle(height: 1.2),
                    ),
                  ],
                ),

                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 12),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         _resultDataList[index].resultTitle,
                //         style: const TextStyle(
                //           fontSize: 24,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //       Text(
                //         _resultDataList[index].resultDescription,
                //         overflow: TextOverflow.ellipsis,
                //         maxLines: 1,
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
