import 'dart:async';

import 'constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'LevelSelector.dart';
import 'Login.dart';
import 'gsheetAPI.dart' as gsheet;
import 'welcome_screen.dart';

var words = [];
var answers = ['', '', '', '', '', '', '', '', '', '', '', '', '', ''];
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
        home: ScorePage(),
        // home: MyHomePage(title: 'Dictation App'),
        // home: LevelSelector(),
        // home: PushDataToSheets(),
        // home: WelcomeScreen(),
        // home: Login(),
        // home: TestList(),
        routes: {
          '/dictation-test': (_) => MyHomePage(title: 'title'),
          '/login': (_) => Login(),
          '/score': (_) => ScorePage(),
          '/levels': (_) => StackDemo(),
        });
  }
}

class ScorePage extends StatelessWidget {
  ScorePage({Key? key}) : super(key: key);
  final items = List.generate(20, (counter) => 'Item: $counter');

  Widget buildVerticalListView() => ListView.separated(
        separatorBuilder: (context, index) => Divider(color: Colors.black),
        itemCount: _counter,
        itemBuilder: (context, index) {
          final item = answers[index];

          return ListTile(
            title: Text(item),
            subtitle: item == words[index] ? Text("correct") : Text("wrong"),
          );
        },
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // SvgPicture.asset("asset/images/bg.svg", fit: BoxFit.fill),
          Column(
            children: [
              Spacer(flex: 1),
              Text(
                "Score",
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    ?.copyWith(color: kSecondaryColor),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${score}/${_counter}",
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      ?.copyWith(color: kSecondaryColor),
                ),
              ),
              Spacer(flex: 1),
              Center(
                  child:
                      Container(height: 333, child: buildVerticalListView())),

              Spacer(),
              Container(
                height: 50,
                width: 120,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: ElevatedButton(
                  onPressed: () {
                    ResetDataOfApp();
                    Navigator.pushNamed(context, '/levels');
                  },
                  child: Icon(Icons.arrow_back),
                ),
              ),
              Spacer(),
              // buildVerticalListView(),
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
  answers = ['', '', '', '', '', '', '', '', '', '', '', '', '', ''];
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
  calculateScore() {
    score = 0;
    var length_words = _counter;
    if (length_words < score) {
      length_words = _counter;
    }
    for (int i = 0; i < length_words + 1; i++) {
      answers[i].toLowerCase();
      answers[i].replaceAll(new RegExp(r"\s+"), ""); // remove all spaces
      // print(answers[i]);
      print(words[i]);
      if (answers[i] == words[i]) {
        setState(() {
          score++;
        });
      }
    }
  }

  // int score = 0;

  incrementCounter() {
    setState(() {
      _counter++;
    });
    // print(controlerOfTheAnsField.text);
    controlerOfTheAnsField.clear();
  }

  decrementCounter() {
    if (_counter == 0) {
      return;
    }
    setState(() {
      _counter--;
    });
    // print(controlerOfTheAnsField.text);
    controlerOfTheAnsField.text = answers[_counter % modOperator];
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
            incrementCounter();
            calculateScore();
            // ResetDataOfApp();
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
                    if (answers.length < widget.wordIndex) {
                      answers.add("");
                    }
                    answers[widget.wordIndex] = str;
                    print(answers);
                    print(controlerOfTheAnsField.text);
                  });
                }),
          ),
          // Text(wordAnswer),
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
              print("");
              print(this.wordToSpeak);
              print("");
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
          // Text(this.wordToSpeak),
        ],
      ),
    );
  }
}
