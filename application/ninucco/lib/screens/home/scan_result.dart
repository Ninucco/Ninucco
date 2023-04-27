import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:ninucco/providers/nav_provider.dart';
import 'package:ninucco/utilities/scan_list_data.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:wrapped_korean_text/wrapped_korean_text.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AnalyticItem {
  final String keyword;
  final double value;

  AnalyticItem({required this.keyword, required this.value});

  factory AnalyticItem.fromJson(Map<String, dynamic> parsedJson) {
    return AnalyticItem(
      keyword: parsedJson['keyword'],
      value: parsedJson['value'],
    );
  }
}

class ResultData {
  final int type;
  final String resultTitle;
  final String resultDescription;
  final String imgUrl;
  final List<AnalyticItem> resultPercentages;

  ResultData({
    required this.type,
    required this.resultTitle,
    required this.resultDescription,
    required this.imgUrl,
    required this.resultPercentages,
  });

  factory ResultData.fromJson(Map<String, dynamic> json) {
    var list = json['resultPercentages'] as List;
    List<AnalyticItem> analyticItemList =
        list.map((i) => AnalyticItem.fromJson(i)).toList();
    return ResultData(
      type: json['type'],
      resultTitle: json['resultTitle'],
      resultDescription: json['resultDescription'],
      imgUrl: json['imgUrl'],
      resultPercentages: analyticItemList,
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
  late NavProvider _navProvider;

  ResultData _resultData = ResultData(
    type: 0,
    resultTitle: 'title',
    resultDescription: 'description',
    imgUrl: 'imageUrl',
    resultPercentages: [],
  );

  @override
  void initState() {
    _resultData = widget.settings.arguments as ResultData;
    _scanUtility = ScanUtility();
    _navProvider = Provider.of<NavProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void handleKakaoShare() {
      // ShareClient.instance.launchKakaoTalk(uri)
    }
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
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/bg/bg2.png',
                repeat: ImageRepeat.repeat,
                fit: BoxFit.fitWidth,
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black54,
                            offset: Offset(4, 4),
                          )
                        ],
                      ),
                      child: CachedNetworkImage(
                        imageUrl: _resultData.imgUrl,
                        width: double.infinity,
                        fit: BoxFit.fill,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                      ),
                    ),
                    const SizedBox(height: 32),
                    // 제목
                    WrappedKoreanText(
                      _resultData.resultTitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 6.0,
                            color: Colors.black38,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 분석 퍼센티지
                    for (var item in _resultData.resultPercentages)
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
                    // 분석내용

                    WrappedKoreanText(
                      _resultData.resultDescription,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        height: 1.8,
                      ),
                    ),
                    // 버튼1
                    const SizedBox(height: 32),
                    const ShareButton(),
                    // 버튼2
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        _navProvider.showBottomNav();
                        Navigator.pushNamed(context, '/');
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 18),
                        decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        width: double.infinity,
                        child: const Text(
                          "다른 테스트 하러가기",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ShareButton extends StatefulWidget {
  const ShareButton({
    super.key,
  });

  @override
  State<ShareButton> createState() => _ShareButtonState();
}

class _ShareButtonState extends State<ShareButton> {
  final FeedTemplate defaultFeed = FeedTemplate(
    content: Content(
      title: '딸기 치즈 케익',
      description: '#케익 #딸기 #삼평동 #카페 #분위기 #소개팅',
      imageUrl: Uri.parse(
          'https://mud-kage.kakao.com/dn/Q2iNx/btqgeRgV54P/VLdBs9cvyn8BJXB3o7N8UK/kakaolink40_original.png'),
      link: Link(
          webUrl: Uri.parse('https://developers.kakao.com'),
          mobileWebUrl: Uri.parse('https://developers.kakao.com')),
    ),
    itemContent: ItemContent(
      profileText: 'Kakao',
      profileImageUrl: Uri.parse(
          'https://mud-kage.kakao.com/dn/Q2iNx/btqgeRgV54P/VLdBs9cvyn8BJXB3o7N8UK/kakaolink40_original.png'),
      titleImageUrl: Uri.parse(
          'https://mud-kage.kakao.com/dn/Q2iNx/btqgeRgV54P/VLdBs9cvyn8BJXB3o7N8UK/kakaolink40_original.png'),
      titleImageText: 'Cheese cake',
      titleImageCategory: 'cake',
      items: [
        ItemInfo(item: 'cake1', itemOp: '1000원'),
        ItemInfo(item: 'cake2', itemOp: '2000원'),
        ItemInfo(item: 'cake3', itemOp: '3000원'),
        ItemInfo(item: 'cake4', itemOp: '4000원'),
        ItemInfo(item: 'cake5', itemOp: '5000원')
      ],
      sum: 'total',
      sumOp: '15000원',
    ),
    social: Social(likeCount: 286, commentCount: 45, sharedCount: 845),
    buttons: [
      Button(
        title: '웹으로 보기',
        link: Link(
          webUrl: Uri.parse('https: //developers.kakao.com'),
          mobileWebUrl: Uri.parse('https: //developers.kakao.com'),
        ),
      ),
      Button(
        title: '앱으로보기',
        link: Link(
          androidExecutionParams: {'key1': 'value1', 'key2': 'value2'},
          iosExecutionParams: {'key1': 'value1', 'key2': 'value2'},
        ),
      ),
    ],
  );

  void handleKakaoShare() async {
    bool isKakaoTalkSharingAvailable =
        await ShareClient.instance.isKakaoTalkSharingAvailable();
    print(isKakaoTalkSharingAvailable);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleKakaoShare,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
        decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        width: double.infinity,
        child: const Text(
          "공유하기",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
