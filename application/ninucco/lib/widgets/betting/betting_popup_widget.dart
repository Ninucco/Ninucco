import 'package:flutter/material.dart';
import 'package:ninucco/models/battle_betting_request_model.dart';
import 'package:ninucco/providers/auth_provider.dart';
import 'package:ninucco/services/betting_api_service.dart';
import 'package:provider/provider.dart';

class BettingPopupWidget extends StatefulWidget {
  final int memberId, battleId;
  final String nickname, type;

  const BettingPopupWidget({
    super.key,
    required this.memberId,
    required this.battleId,
    required this.nickname,
    required this.type,
  });

  @override
  State<BettingPopupWidget> createState() => _BettingPopupWidgetState();
}

class _BettingPopupWidgetState extends State<BettingPopupWidget> {
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return ElevatedButton(
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          useRootNavigator: true,
          context: context,
          builder: (BuildContext context) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: 400,
                padding: const EdgeInsets.all(
                  30,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "'${widget.nickname}'에게",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "포인트를 베팅할까요?",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Image.asset(
                      "assets/images/betting_coin.png",
                      height: 100,
                      width: 100,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "최대 ${authProvider.member!.point} ninu 코인을 베팅할 수 있어요!\n",
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "베팅 금액",
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: 80,
                          height: 20,
                          child: TextField(
                            controller: myController,
                            textAlign: TextAlign.center,
                            showCursor: true,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Text(
                          " Point",
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 150,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 5,
                              backgroundColor: Colors.black,
                              shadowColor: Colors.black45,
                            ),
                            child: const Text(
                              '아니오',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () => {
                              Navigator.pop(context),
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '베팅을 취소했어요',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, '네!'),
                                      child: const Text(
                                        '네!',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        SizedBox(
                          width: 150,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 5,
                              backgroundColor: Colors.white,
                              shadowColor: Colors.black45,
                            ),
                            child: const Text(
                              '네',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () => {
                              Navigator.pop(context),
                              BettingApiService.postBetting(
                                  BattleBettingRequestModel(
                                widget.battleId,
                                int.parse(myController.text),
                                widget.type,
                                authProvider.member!.id,
                              )),
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '베팅이 완료됐어요',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, '야호!'),
                                      child: const Text(
                                        '야호!',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      style: ElevatedButton.styleFrom(
          elevation: 5,
          backgroundColor: Colors.black,
          shadowColor: Colors.black45),
      child: const Text(
        "여기에 베팅하기",
        style: TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }
}
