import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:ninucco/screens/home/scan_result.dart';
import 'package:path_provider/path_provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class PhotoUtility {
  static Future<void> saveImage(context, url) async {
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

  static Future<void> photoLongPress(context, ResultData result) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('이미지 저장'),
        content: SizedBox(
          height: 125,
          child: Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 12,
                  ),
                ),
                onPressed: () {
                  PhotoUtility.saveImage(context, result.imgUrl);
                },
                child: const Row(
                  children: [
                    Text(
                      '이미지 저장',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffFEE600),
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 12,
                  ),
                ),
                onPressed: () {
                  PhotoUtility.handleKakaoShare(result);
                },
                child: const Row(
                  children: [
                    Text(
                      '카카오톡으로 공유하기',
                      style: TextStyle(
                        // #47292B
                        color: Color(0xff47292B),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static FeedTemplate createShareTemplate(ResultData data) {
    return FeedTemplate(
      content: Content(
        title: data.resultTitle,
        description: data.resultDescription.split('\n').sublist(0, 2).join(' '),
        imageUrl: Uri.parse(data.imgUrl),
        link: Link(
          webUrl: Uri.parse('https://developers.kakao.com'),
          mobileWebUrl: Uri.parse('https://developers.kakao.com'),
        ),
      ),
      buttons: [
        Button(
          title: '자세히 보기',
          link: Link(
            androidExecutionParams: {'key1': 'value1', 'key2': 'value2'},
            iosExecutionParams: {'key1': 'value1', 'key2': 'value2'},
          ),
        ),
      ],
    );
  }

  static void handleKakaoShare(ResultData data) async {
    bool isKakaoTalkSharingAvailable =
        await ShareClient.instance.isKakaoTalkSharingAvailable();

    try {
      if (isKakaoTalkSharingAvailable) {
        Uri uri = await ShareClient.instance
            .shareDefault(template: createShareTemplate(data));
        await ShareClient.instance.launchKakaoTalk(uri);
      }
    } catch (err) {
      print('카카오톡 공유 실패 $err');
    }
  }
}
