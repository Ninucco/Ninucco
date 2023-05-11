import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ninucco/providers/test_provider.dart';
import 'package:ninucco/utilities/date_utils.dart';
import 'package:ninucco/models/album.dart';
import 'package:ninucco/widgets/test_button.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late TestProvider _testProvider;
  late Future<Album> futureAlbum;
  final nowDate = DateUtility.weekdays[6];

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    _testProvider = Provider.of<TestProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<Album>(
              future: futureAlbum,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data!.title);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            ),
            Text(
              _testProvider.count.toString(),
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            Text(
              nowDate.toString(),
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const TestButton(text: 'hello', onPressed: null),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () => _testProvider.increase(),
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () => _testProvider.decrease(),
            icon: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
