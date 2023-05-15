import 'package:flutter/material.dart';
import 'package:ninucco/models/user_detail_model.dart';
import 'package:ninucco/providers/auth_provider.dart';
import 'package:ninucco/services/user_service.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ProfileSettings extends StatelessWidget {
  final RouteSettings settings;
  const ProfileSettings({
    super.key,
    required this.settings,
  });

  @override
  Widget build(BuildContext context) {
    var userData = settings.arguments as UserDetailData;
    return Scaffold(
      appBar: AppBar(title: const Text("프로필 설정")),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
          minWidth: MediaQuery.of(context).size.width,
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg/bg2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(child: FormData(userData: userData)),
        ),
      ),
    );
  }
}

class FormData extends StatefulWidget {
  const FormData({
    super.key,
    required this.userData,
  });

  final UserDetailData userData;

  @override
  State<FormData> createState() => _FormDataState();
}

class _FormDataState extends State<FormData> {
  final formKey = GlobalKey<FormState>();

  String nickname = '';
  String newProfileUrl = '';
  bool existNickname = false;
  @override
  void initState() {
    newProfileUrl == widget.userData.user.profileImage;
    nickname == widget.userData.user.nickname;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var currentUser = Provider.of<AuthProvider>(context, listen: false)
        .getFireBaseAuth
        .currentUser;

    var authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 32),
          Stack(
            children: [
              CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(
                  newProfileUrl != ''
                      ? newProfileUrl
                      : widget.userData.user.profileImage,
                ),
              ),
              Positioned(
                bottom: 0,
                right: -6,
                child: ElevatedButton(
                  onPressed: () async {
                    var selectedUrl = await Navigator.pushNamed(
                      context,
                      "/ProfileImagePicker",
                      arguments: {
                        "userData": widget.userData,
                        'selectedUrl': newProfileUrl,
                      },
                    ) as String;
                    setState(() {
                      newProfileUrl = selectedUrl;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(8),
                    backgroundColor: Colors.white, // <-- Button color
                  ),
                  child: const Icon(
                    Icons.edit,
                    color: Colors.black,
                    size: 16,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 32),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: const BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Column(
              children: [
                const Row(
                  children: [
                    Text(
                      "닉네임",
                      style: TextStyle(color: Colors.black45),
                    ),
                  ],
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.only(top: 8),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  initialValue: widget.userData.user.nickname,
                  onSaved: (newValue) {
                    setState(() {
                      nickname = newValue ?? "";
                    });
                  },
                  onChanged: (text) async {
                    final check = await UserService.existNickName(text);
                    setState(() => existNickname = check);
                  },
                  validator: (value) {
                    if (value!.length < 3 || value.length > 15) {
                      return "닉네임은 3~5글자 사이로 설정해주세요";
                    }
                    if (!existNickname) {
                      return "존재하는 닉네임 입니다.";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          currentUser!.isAnonymous
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      String result =
                          await authProvider.convertAnonymousToGoogle();
                      if (context.mounted) {
                        if (result == 'Google Account Already Exist') {
                          showTopSnackBar(
                            Overlay.of(context),
                            const CustomSnackBar.error(
                              message: '이미 해당 계정과 연동된 유저가 존재합니다.',
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/google_logo.png',
                          height: 15,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          '구글 계정 연동하기',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: const BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            "구글 이메일",
                            style: TextStyle(color: Colors.black45),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/google_logo.png',
                            height: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            currentUser.email ?? "",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
          const SizedBox(height: 16),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
              ),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  showTopSnackBar(
                    Overlay.of(context),
                    const CustomSnackBar.success(
                      message:
                          'Good job, your release is successful. Have a nice day',
                    ),
                  );
                }
              },
              child: const Text(
                "저장하기",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  )),
              onPressed: () {
                authProvider.signOut();
              },
              child: const Text(
                "로그아웃",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
