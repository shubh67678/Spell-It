import 'package:flutter/material.dart';
import 'not_used/test_to_voice.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

var words = ["test", "best", "next", "happy"];
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
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Dictation App'),
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
  // loadJson() async {
  //   String data = await rootBundle.loadString('lib/words_test.json');
  //   var jsonResult = json.decode(data);
  // }

  incrementCounter() {
    setState(() {
      _counter++;
    });
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
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [LoopOverWords()]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.arrow_forward),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class LoopOverWords extends StatefulWidget {
  LoopOverWords({Key? key}) : super(key: key);

  @override
  _LoopOverWordsState createState() => _LoopOverWordsState();
}

class _LoopOverWordsState extends State<LoopOverWords> {
  int _counter = 0;
  incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  getWord() {
    print(words[1]);
    return "omega";
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Column(
        children: <Widget>[
          SpeakTheWordButton(getWord()),
          GetUserAnswerForWord(),
        ],
      ),
    );
  }
}

class GetUserAnswerForWord extends StatefulWidget {
  GetUserAnswerForWord({Key? key}) : super(key: key);

  @override
  _GetUserAnswerForWordState createState() => _GetUserAnswerForWordState();
}

class _GetUserAnswerForWordState extends State<GetUserAnswerForWord> {
  String wordAnswer = '';
  TextEditingController controlerOfTheAnsField = new TextEditingController();

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextField(
              keyboardType: TextInputType.visiblePassword,
              decoration: const InputDecoration(
                hintText: 'Type your answer here',
              ),
              onSubmitted: (String str) {
                setState(() {
                  wordAnswer = str;
                });
              }),
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
