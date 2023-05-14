import 'package:flutter/material.dart';
import 'package:ninucco/models/user_model.dart';
import 'package:ninucco/services/search_by_nickname_service.dart';
import 'package:ninucco/widgets/battle/battle_searched_member_item_widget.dart';

class BattleFriendSearchScreen extends StatefulWidget {
  // final String keyword;
  RouteSettings settings;
  BattleFriendSearchScreen({
    super.key,
    // required this.keyword,
    required this.settings,
  });
  @override
  State<BattleFriendSearchScreen> createState() =>
      _BattleFriendSearchScreenState();
}

class _BattleFriendSearchScreenState extends State<BattleFriendSearchScreen> {
  String _keyword = '';

  @override
  void initState() {
    _keyword = widget.settings.arguments as String;
    super.initState();
  }

  void searchByUsername(String value) async {
    setState(() {
      _keyword = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<List<UserModel>> userList =
        UserSearchApiService.searchUserByNickname(_keyword);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Layout(
        keyword: _keyword,
        searchByUsername: searchByUsername,
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            const SizedBox(height: 20),
            FutureBuilder(
              future: userList,
              builder: (context, snapshot) => snapshot.hasData
                  ? resultUsers(snapshot)
                  : const CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }

  ListView resultUsers(AsyncSnapshot<List<UserModel>> snapshot) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data!.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var user = snapshot.data![index];
        return BattleSearchedMemberItem(
          id: user.id,
          profileImage: user.profileImage,
          nickname: user.nickname,
        );
      },
    );
  }
}

class Layout extends StatelessWidget {
  final Widget child;
  final searchByUsername;
  final String keyword;
  const Layout({
    super.key,
    required this.child,
    required this.searchByUsername,
    required this.keyword,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 80,
        leadingWidth: 30,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined,
              color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextFormField(
            textInputAction: TextInputAction.search,
            initialValue: keyword,
            onFieldSubmitted: searchByUsername,
            style: const TextStyle(fontSize: 16),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "친구검색",
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg/bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: child),
    );
  }
}
