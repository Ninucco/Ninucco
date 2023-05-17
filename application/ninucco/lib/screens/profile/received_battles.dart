import 'package:flutter/material.dart';
import 'package:ninucco/models/user_detail_model.dart';
import 'package:ninucco/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class ReceivedBattles extends StatelessWidget {
  final RouteSettings settings;
  const ReceivedBattles({
    super.key,
    required this.settings,
  });

  @override
  Widget build(BuildContext context) {
    var userDetailData = settings.arguments as UserDetailData;
    var me = Provider.of<AuthProvider>(context).member;

    return Scaffold(
      appBar: AppBar(
        title: const Text("대기중인 대결목록"),
      ),
      body: SingleChildScrollView(
          child: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height -
              AppBar().preferredSize.height -
              92,
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg/bg2.png'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsetsDirectional.symmetric(
          vertical: 16,
          horizontal: 12,
        ),
        child: Column(
          children: userDetailData.receivedBattles
              .map((battleData) => Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    padding: const EdgeInsetsDirectional.symmetric(
                      vertical: 16,
                      horizontal: 12,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3,
                          color: Colors.black26,
                          offset: Offset(3, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/Profile',
                              arguments: battleData.applicantId,
                            );
                          },
                          child: Row(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blueAccent,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  battleData.applicantName,
                                  style: const TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Text('님으로 부터 온 대결신청'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          battleData.title,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.width * 0.8,
                          child: Image.network(
                            battleData.applicantUrl,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        me?.id != null && me?.id == userDetailData.user.id
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red),
                                      ),
                                      onPressed: () {},
                                      child: const Text("거절",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          "/BattleApprove",
                                          arguments: battleData,
                                        );
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.green),
                                      ),
                                      child: const Text("수락",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  )
                                ],
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ))
              .toList(),
        ),
      )),
    );
  }
}
