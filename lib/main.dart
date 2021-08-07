import 'dart:async';

import 'package:flutter/material.dart';
import 'not_used/test_to_voice.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'loadJsonData.dart';

var words = ["test", "best", "next", "happy"];
var answers = ['', '', '', '', '', ''];
final controlerOfTheAnsField = TextEditingController();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Dictation App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: MyHomePage(title: 'Dictation App'),
        // home: LoginDemo(),
        home: StackDemo(),
        routes: {
          '/testpage': (_) => MyHomePage(title: 'title'),
          '/login': (_) => LoginDemo(),
        });
  }
}

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
  words =
      totalJson[level].cast<String>(); // convert list dynamic to list string
  print(words);
  // print(level);
  // print(totalJson);
  // print(totalJson["1"]);
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

class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  // padding: const EdgeInsets.only(
                  // left: 15.0, right: 15.0, top: 0, bottom: 0),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        hintText: 'Enter your full name'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Enter your emailId'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/testpage');
                      },
                      child: Text(
                        'Start the Game!',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var modOperator = 3;

  int score = 0;

  incrementCounter() {
    setState(() {
      _counter++;
    });
    print(controlerOfTheAnsField.text);
    controlerOfTheAnsField.clear();
  }

  decrementCounter() {
    setState(() {
      _counter--;
    });
    print(controlerOfTheAnsField.text);
    controlerOfTheAnsField.text = answers[_counter % modOperator];
  }

  calculateScore() {
    score = 0;
    for (int i = 0; i < 3; i++) {
      answers[i].toLowerCase();
      answers[i].replaceAll(new RegExp(r"\s+"), ""); // remove all spaces

      if (answers[i] == words[i]) {
        setState(() {
          score++;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        LoopOverWords2(_counter),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // ElevatedButton(
            //   onPressed: decrementCounter,
            //   child: Icon(Icons.arrow_back),
            // ),
            // ElevatedButton(
            //   onPressed: incrementCounter,
            //   child: Icon(Icons.arrow_forward),
            // ),
            Container(
              height: 50,
              width: 120,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: decrementCounter,
                child: Icon(Icons.arrow_back),
              ),
            ),
            Container(
              height: 50,
              width: 120,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: incrementCounter,
                child: Icon(Icons.arrow_forward),
              ),
            ),
          ],
        )
      ]),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class LoopOverWords2 extends StatelessWidget {
  final int wordIndex;
  var modOperator = 3;
  LoopOverWords2(this.wordIndex);
  getWord() {
    var finalWordIndex = this.wordIndex % modOperator;
    return words[finalWordIndex];
    // return "omega";
  }

  @override
  Widget build(BuildContext context) {
    return
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        SpeakTheWordButton(getWord()),
        GetUserAnswerForWord(this.wordIndex % modOperator),
      ],
    );
  }
}

class GetUserAnswerForWord extends StatefulWidget {
  final int wordIndex;
  // const GetUserAnswerForWord(wordIndex);
  // GetUserAnswerForWord({Key? key, wordIndex}) : super(key: key);
  const GetUserAnswerForWord(this.wordIndex);
  @override
  _GetUserAnswerForWordState createState() => _GetUserAnswerForWordState();
}

class _GetUserAnswerForWordState extends State<GetUserAnswerForWord> {
  String wordAnswer = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
                controller: controlerOfTheAnsField,
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Type your answer here',
                ),
                //     decoration: const InputDecoration(
                //       border: OutlineInputBorder(),
                //       labelText: 'Name',
                //       hintText: 'Enter your full name'),
                // ),
                onChanged: (String str) {
                  setState(() {
                    wordAnswer = str;
                    answers[widget.wordIndex] = str;
                    print(answers);
                    print(controlerOfTheAnsField.text);
                  });
                }),
          ),
          Text(wordAnswer),
        ],
      ),
    );
  }
}

class SpeakTheWordButton extends StatelessWidget {
  final String wordToSpeak;
  SpeakTheWordButton(this.wordToSpeak);
  final FlutterTts flutterTts = FlutterTts();

  speak(String to_speak) async {
    await flutterTts.setVolume(1);
    await flutterTts.speak(to_speak);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              speak(this.wordToSpeak);
            },
            child: Text(
              "Speak",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            style: ButtonStyle(
              shape: MaterialStateProperty.all(CircleBorder()),
              padding: MaterialStateProperty.all(EdgeInsets.all(50)),
              backgroundColor:
                  MaterialStateProperty.all(Colors.blue), // <-- Button color
            ),
          ),
          Text(this.wordToSpeak),
        ],
      ),
    );
  }
}
