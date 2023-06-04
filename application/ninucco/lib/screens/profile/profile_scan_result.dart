import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:ninucco/screens/home/scan_result.dart';
import 'package:ninucco/utilities/photo_utils.dart';
import 'package:ninucco/utilities/scan_list_data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:http/http.dart' as http;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:uuid/uuid.dart';

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
  final ItemScrollController _scrollController = ItemScrollController();

  @override
  void initState() {
    var incomeData = widget.settings.arguments as ProfileScanResultsArgs;
    // var width = MediaQuery.of(context).size.width;
    _selectedId = incomeData.selectedId;
    _resultDataList = incomeData.data;
    _scanUtility = ScanUtility();
    super.initState();
  }

  final colorsList = [
    0xffBF00FE,
    0xff00A86B,
    0xff0F52BA,
    0xffD10173,
    0xffA8AAAE
  ];

  Future<void> _saveImage(BuildContext context, String url) async {
    var uuid = const Uuid();

    try {
      final http.Response response = await http.get(Uri.parse(url));
      final dir = await getTemporaryDirectory();
      var filename = '${dir.path}/${uuid.v1()}.png';
      final file = File(filename);
      await file.writeAsBytes(response.bodyBytes);

      // Ask the user to save it
      final params = SaveFileDialogParams(sourceFilePath: file.path);
      final finalPath = await FlutterFileDialog.saveFile(params: params);

      if (finalPath != null) {
        if (!mounted) return;
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.success(
            message: '저장 되었습니다.',
          ),
        );
      }
    } catch (e) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: '에러로 저장하지 못했습니다.',
        ),
      );
    }
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
      body: ScrollablePositionedList.builder(
        itemScrollController: _scrollController,
        initialScrollIndex: _selectedId,
        itemCount: _resultDataList.length,
        itemBuilder: (context, index) {
          var scanData = _resultDataList[_resultDataList.length - index - 1];
          return Column(
            children: [
              GestureDetector(
                onLongPress: () => PhotoUtility.photoLongPress(
                  context,
                  scanData,
                ),
                child: CachedNetworkImage(
                  imageUrl: scanData.imgUrl,
                  fit: BoxFit.fitWidth,
                ),
              ),
              ExpansionTile(
                title: Text(
                  "${_scanUtility!.getTypeMap[scanData.modelType]} 결과",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                childrenPadding:
                    const EdgeInsets.only(left: 12, right: 12, bottom: 16),
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 32,
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        scanData.resultTitle,
                        style: const TextStyle(fontSize: 40),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: List.from(scanData.resultPercentages
                            .asMap()
                            .entries
                            .map((data) {
                              var prefixSum = 0.0;
                              scanData.resultPercentages
                                  .asMap()
                                  .forEach((i, value) {
                                if (data.key >= i) {
                                  prefixSum += value.value;
                                }
                              });

                              return CircularPercentIndicator(
                                radius: MediaQuery.of(context).size.width * 0.2,
                                animation: true,
                                animationDuration: 1000,
                                center: data.key == 0
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            data.value.keyword,
                                            style: const TextStyle(
                                              fontSize: 32,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                              "${(data.value.value * 100).round()}%"),
                                        ],
                                      )
                                    : null,
                                percent: prefixSum > 1 ? 1 : prefixSum,
                                backgroundColor: data.key ==
                                        scanData.resultPercentages.length - 1
                                    ? Colors.black12
                                    : Colors.transparent,
                                progressColor: Color(colorsList[data.key]),
                              );
                            })
                            .toList()
                            .reversed),
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: scanData.resultPercentages
                              .asMap()
                              .entries
                              .map((entry) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                    0.6 -
                                                48,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(entry.value.keyword),
                                            Text(
                                                "${(entry.value.value * 100).round()}%")
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      LinearPercentIndicator(
                                        animation: true,
                                        animationDuration: 1000,
                                        padding: EdgeInsets.zero,
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                    0.6 -
                                                48,
                                        percent: entry.value.value > 1
                                            ? 1
                                            : entry.value.value,
                                        progressColor:
                                            Color(colorsList[entry.key]),
                                        barRadius: const Radius.circular(12),
                                        backgroundColor: Colors.black12,
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                  ))
                              .toList()),
                    ],
                  ),
                  const Divider(color: Colors.black54, height: 48),
                  Text(
                    style: const TextStyle(height: 1.2),
                    scanData.resultDescription,
                    // overflow: TextOverflow.ellipsis,
                    // maxLines: 5,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
