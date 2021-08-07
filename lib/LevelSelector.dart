import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'not_used/test_to_voice.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'loadJsonData.dart';
import 'main.dart' as main;

class LevelSelector extends StatelessWidget {
  const LevelSelector({Key? key}) : super(key: key);
  // width = MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    double height_of_device = MediaQuery.of(context).size.height;
    var width_of_device = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Select level")),
      body: Center(
        child: Card(
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              print('Card tapped.');
            },
            child: const SizedBox(
              width: 200,
              height: 60,
              child: Text('A card that can be tapped'),
            ),
          ),
        ),
      ),
    );
  }
}

SetAnwerWrtLevel(String level) async {
  var totalJson = await getTheJsonData();
  main.words =
      totalJson[level].cast<String>(); // convert list dynamic to list string
  // print(words);
}

class StackDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SafeArea(
        child: Center(
            child: ListView(children: <Widget>[
          LevelCard(1),
          LevelCard(2),
          LevelCard(3),
          LevelCard(4),
          LevelCard(5),
          LevelCard(6),
          LevelCard(7),
          LevelCard(8),
        ])),
      ),
    );
  }
}

class LevelCard extends StatelessWidget {
  final int level_number;
  LevelCard(this.level_number);
  Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
    print('--- Parse json from: $assetsPath');
    return rootBundle
        .loadString(assetsPath)
        .then((jsonStr) => jsonDecode(jsonStr));
  }

  var path = "asset/data.json";
  getTheJsonData() async {
    Map<String, dynamic> dmap = await parseJsonFromAssets(path);
    return dmap;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Card(
        elevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        color: Colors.white,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            print('Card tapped.');
            SetAnwerWrtLevel(level_number.toString());
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Level " + level_number.toString(),
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.navigate_next,
                  size: 36,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
