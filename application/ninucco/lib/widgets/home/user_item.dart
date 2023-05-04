import 'package:flutter/material.dart';

class UserItem extends StatelessWidget {
  final String profileImage, nickname, id;
  final int winCount, loseCount;
  final bool isFriend;

  const UserItem({
    super.key,
    required this.profileImage,
    required this.nickname,
    required this.id,
    required this.winCount,
    required this.loseCount,
    required this.isFriend,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6),
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Image.network(
                  profileImage,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      nickname,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '승리 $winCount 패배 $loseCount',
                      style: const TextStyle(color: Colors.black54),
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
}
