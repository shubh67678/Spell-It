import 'dart:async';

import 'package:flutter/material.dart';
import 'not_used/test_to_voice.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

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
        home: MyHomePage(title: 'Dictation App'),
        // home: LoginDemo(),
        routes: {
          '/testpage': (_) => MyHomePage(title: 'title'),
          '/login': (_) => LoginDemo(),
        });
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
                    child: FlatButton(
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
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          LoopOverWords2(_counter),
          Text("test"),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: calculateScore,
            child: Text('Calculate Score'),
          ),
          Text(score.toString()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: decrementCounter,
                child: Icon(Icons.arrow_back),
              ),
              ElevatedButton(
                onPressed: incrementCounter,
                child: Icon(Icons.arrow_forward),
              ),
            ],
          )
        ]),
      ),

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
    return Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Column(
        children: <Widget>[
          SpeakTheWordButton(getWord()),
          GetUserAnswerForWord(this.wordIndex % modOperator),
        ],
      ),
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
          TextField(
              controller: controlerOfTheAnsField,
              keyboardType: TextInputType.visiblePassword,
              // decoration: const InputDecoration(
              //   hintText: 'Type your answer here',
              // ),
              onChanged: (String str) {
                setState(() {
                  wordAnswer = str;
                  answers[widget.wordIndex] = str;
                  print(answers);
                  print(controlerOfTheAnsField.text);
                });
              }),
          Text(wordAnswer),
          Text(widget.wordIndex.toString()),
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
    return Container(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              speak(this.wordToSpeak);
            },
            child: Icon(Icons.campaign),
            style: ButtonStyle(
              shape: MaterialStateProperty.all(CircleBorder()),
              padding: MaterialStateProperty.all(EdgeInsets.all(20)),
              backgroundColor:
                  MaterialStateProperty.all(Colors.blue), // <-- Button color
              overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                if (states.contains(MaterialState.pressed))
                  return Colors.red; // <-- Splash color
              }),
            ),
          ),
          Text(this.wordToSpeak),
        ],
      ),
    );
  }
}
