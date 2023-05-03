import 'package:flutter/material.dart';
import 'package:ninucco/models/user_rank_info_model.dart';
import 'package:ninucco/services/user_rank_api_service.dart';
import 'package:ninucco/widgets/ranking/ranking_item_widget.dart';

class SearchScreen extends StatefulWidget {
  final RouteSettings settings;

  const SearchScreen({super.key, required this.settings});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _keyword = '';
  Future<List<UserRankInfoModel>> userRanks = UserRankApiService.getUserRanks();
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Layout(
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            const SizedBox(height: 20),
            Text(_keyword),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  const Color(0xffF7D1ED).withOpacity(0.7),
                  const Color(0xffC8CDFA).withOpacity(0.7),
                ]),
                borderRadius: BorderRadius.circular(6),
              ),
              child: TextFormField(
                textInputAction: TextInputAction.search,
                onFieldSubmitted: searchByUsername,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "친구검색",
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            FutureBuilder(
              future: userRanks,
              builder: (context, snapshot) => snapshot.hasData
                  ? resultUsers(snapshot)
                  : const CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }

  ListView resultUsers(AsyncSnapshot<List<UserRankInfoModel>> snapshot) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data!.length,
      physics: const NeverScrollableScrollPhysics(),
      // padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemBuilder: (context, index) {
        var userRank = snapshot.data![index];
        return RankingItem(
          id: userRank.id,
          profileImage: userRank.profileImage,
          nickname: "뛰어난 수장룡",
          topSimilarity: "방금 막 자다깬 유니콘상",
          index: index,
        );
      },
    );
  }
}

class Layout extends StatelessWidget {
  final Widget child;
  const Layout({super.key, required this.child});

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
      body: Container(
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
