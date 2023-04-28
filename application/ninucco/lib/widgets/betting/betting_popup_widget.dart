import 'package:flutter/material.dart';

class BettingPopupWidget extends StatelessWidget {
  final int memberId, posessCoin;
  final String nickname;

  const BettingPopupWidget({
    super.key,
    required this.memberId,
    required this.nickname,
    required this.posessCoin,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showModalBottomSheet(
          useRootNavigator: true,
          context: context,
          builder: (BuildContext context) {
            return Container(
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
                        "'$nickname'에게",
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
                    "최대 $posessCoin ninu 코인을 베팅할 수 있어요!\n",
                    style: const TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "배팅 금액",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        "50 Point",
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
                          onPressed: () => Navigator.pop(context),
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
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),
                ],
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
