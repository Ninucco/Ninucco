import 'package:flutter/material.dart';
import 'package:ninucco/models/user_model.dart';
import 'package:ninucco/services/search_by_nickname_service.dart';
import 'package:ninucco/widgets/home/user_item.dart';

class SearchScreen extends StatefulWidget {
  final RouteSettings settings;
  const SearchScreen({super.key, required this.settings});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
      // padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemBuilder: (context, index) {
        var user = snapshot.data![index];
        return UserItem(
          id: user.id,
          profileImage: user.profileImage,
          nickname: user.nickname,
          loseCount: user.loseCount,
          winCount: user.winCount,
          isFriend: index % 2 == 0,
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
      floatingActionButton: RotatedBox(
        quarterTurns: 3,
        child: Container(
          child: const Icon(Icons.chevron_right),
        ),
      ),
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
