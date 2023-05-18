import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ninucco/models/user_detail_model.dart';

class ProfileImagePicker extends StatefulWidget {
  final RouteSettings settings;
  const ProfileImagePicker({
    super.key,
    required this.settings,
  });

  @override
  State<ProfileImagePicker> createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  @override
  Widget build(BuildContext context) {
    var incomeData = widget.settings.arguments as Map<String, dynamic>;
    var userData = incomeData['userData'] as UserDetailData;
    var selectedUrl = incomeData['selectedUrl'] as String;

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('프로필 이미지를 골라주세요'),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context, selectedUrl);
                },
                icon: const Icon(Icons.arrow_back_ios)),
          ),
          userData.scanResultList.isEmpty
              ? SliverToBoxAdapter(
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height - 114,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/bg/bg2.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: const Center(
                      child: Text("먼저 검사를 진행 해주세요"),
                    ),
                  ),
                )
              : SliverGrid.count(
                  crossAxisCount: 3,
                  children: userData.scanResultList
                      .map((el) => GestureDetector(
                            onTap: () {
                              Navigator.pop(context, el.imgUrl);
                            },
                            child: CachedNetworkImage(imageUrl: el.imgUrl),
                          ))
                      .toList(),
                )
        ],
      ),
    );
  }
}
