import 'dart:async';

import 'constants.dart';

import 'package:flutter/material.dart';
import 'not_used/test_to_voice.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'loadJsonData.dart';
import 'LevelSelector.dart';
import 'package:flutter_svg/svg.dart';
import 'Login.dart';

var words = ["test", "best", "next", "happy"];
var answers = ['', '', '', '', '', ''];
int _counter = 0;
var score = 0;
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
        // home: ScoreBoard(),
        // home: MyHomePage(title: 'Dictation App'),
        home: LoginDemo(),
        // home: StackDemo(),
        routes: {
          '/dictation-test': (_) => MyHomePage(title: 'title'),
          '/login': (_) => LoginDemo(),
          '/score': (_) => ScoreBoard(),
          '/levels': (_) => StackDemo(),
        });
  }
}

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset("asset/images/bg.svg", fit: BoxFit.fill),
          Column(
            children: [
              Spacer(flex: 3),
              Text(
                "Score",
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    ?.copyWith(color: kSecondaryColor),
              ),
              Spacer(),
              Text(
                "${score}/${_counter}",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: kSecondaryColor),
              ),
              Spacer(flex: 3),
              Container(
                height: 50,
                width: 120,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/levels');
                  },
                  child: Icon(Icons.arrow_back),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

ResetDataOfApp() {
  words = [];
  answers = [];
  _counter = 0;
  score = 0;
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var modOperator = words.length;

  // int score = 0;

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
    var length_words = _counter;
    if (length_words < score) {
      length_words = _counter;
    }
    for (int i = 0; i < length_words; i++) {
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
        ),
        ElevatedButton(
          onPressed: () {
            ResetDataOfApp();
            Navigator.pushNamed(context, '/score');
            print("ended");
          },
          child: Text("end"),
        ),
      ]),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class LoopOverWords2 extends StatelessWidget {
  final int wordIndex;
  var modOperator = words.length;
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
