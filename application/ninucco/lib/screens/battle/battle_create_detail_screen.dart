import 'package:flutter/material.dart';
import 'package:ninucco/models/battle_create_model.dart';
import 'package:ninucco/models/battle_post_model.dart';
import 'package:ninucco/services/battle_api_service.dart';
import 'package:ninucco/widgets/battle/battle_create_item_widget.dart';
import 'package:ninucco/widgets/common/my_appbar_widget.dart';

class BattleCreateDetailScreen extends StatefulWidget {
  final RouteSettings settings;

  const BattleCreateDetailScreen({
    super.key,
    required this.settings,
  });

  @override
  State<BattleCreateDetailScreen> createState() =>
      _BattleCreateDetailScreenState();
}

class _BattleCreateDetailScreenState extends State<BattleCreateDetailScreen> {
  var result = "???";
  var resultId = "";
  late BattleCreateModel _resultData;
  @override
  void initState() {
    super.initState();
    _resultData = widget.settings.arguments as BattleCreateModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppbarWidget(
        titleText: "배틀 생성 결과",
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height -
              AppBar().preferredSize.height -
              80,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg/bg2.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              BattleCreateItem(
                memberAId: _resultData.memberAId,
                memberAImage: _resultData.memberAImage,
                question: _resultData.question,
                memberANickname: _resultData.memberANickname,
                memberBNickname: result,
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 5,
                ),
                width: MediaQuery.of(context).size.width * 0.75,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    backgroundColor: Colors.white,
                    shadowColor: Colors.black45,
                  ),
                  child: const Text(
                    '배틀 신청할 친구 검색하기',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  ),
                  onPressed: () async {
                    List tmpResult;
                    (await Navigator.pushNamed(context, '/BattleFriendSearch',
                                arguments: "") ==
                            Null)
                        ? tmpResult = await Navigator.pushNamed(
                                context, '/BattleFriendSearch', arguments: "")
                            as List
                        : tmpResult = [];

                    setState(() {
                      (tmpResult.isNotEmpty)
                          ? result = tmpResult[1] as String
                          : result = "???";

                      (tmpResult.isNotEmpty)
                          ? resultId = tmpResult[0] as String
                          : resultId = "";
                    });
                  },
                ),
              ),
              (result != "???")
                  ? Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 5,
                          backgroundColor: Colors.black,
                          shadowColor: Colors.black45,
                        ),
                        child: const Text(
                          '배틀 생성 요청 완료!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                        onPressed: () async {
                          BattleApiService.postBattle(BattlePostModel(
                            _resultData.memberAImage,
                            _resultData.memberAId,
                            resultId,
                            _resultData.question,
                          ));
                          var tmpResult = await Navigator.pushNamed(
                              context, '/BattleAllScreen',
                              arguments: "");
                          setState(() {
                            if (tmpResult != null) {
                              result = tmpResult.toString();
                            }
                          });
                        },
                      ),
                    )
                  : const SizedBox(
                      height: 0,
                    ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "친구가 아직 회원이 아니신가요?",
                textAlign: TextAlign.left,
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 5,
                ),
                width: MediaQuery.of(context).size.width * 0.75,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    backgroundColor: Colors.black,
                    shadowColor: Colors.black45,
                  ),
                  child: const Text(
                    '배틀 초대 링크 생성하기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                  onPressed: () => {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
