import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_svg/svg.dart';

import 'LevelSelector.dart';
import 'constants.dart';
import 'Login.dart';

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
        // home: ScorePage(),
        // home: MyHomePage(title: 'Dictation App'),
        // home: LevelSelector(),
        // home: PushDataToSheets(),
        // home: WelcomeScreen(),
        home: Login(),
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
  Color getTheRightColor(userAnswer, trueAnswer) {
    // if (index == qnController.correctAns) {
    //   return kGreenColor;
    // } else if (index == qnController.selectedAns &&
    //     qnController.selectedAns != qnController.correctAns) {
    //   return kRedColor;
    // }
    return userAnswer == trueAnswer ? kGreenColor : kRedColor;
  }

  Icon getTheRightIcon(userAnswer, trueAnswer) {
    return userAnswer == trueAnswer
        ? Icon(Icons.done, size: 16)
        : Icon(Icons.close, size: 16);
  }

  Widget buildVerticalListView() => ListView.builder(
        itemCount: _counter,
        itemBuilder: (context, index) {
          final userAnswer = answers[index] == "" ? "--" : answers[index];
          final TrueAnswer = words[index];
          getTheRightColor(userAnswer, TrueAnswer);
          return Container(
            margin: EdgeInsets.only(top: kDefaultPadding),
            padding: EdgeInsets.all(kDefaultPadding),
            decoration: BoxDecoration(
              border:
                  Border.all(color: getTheRightColor(userAnswer, TrueAnswer)),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: userAnswer.toString(),
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                        color: getTheRightColor(userAnswer, TrueAnswer)),
                  ),
                ),
                Container(
                  height: 26,
                  width: 26,
                  decoration: BoxDecoration(
                    color: getTheRightColor(userAnswer, TrueAnswer),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                        color: getTheRightColor(userAnswer, TrueAnswer)),
                  ),
                  child: getTheRightColor(userAnswer, TrueAnswer) == kGrayColor
                      ? null
                      : getTheRightIcon(userAnswer, TrueAnswer),
                )
              ],
            ),
          );
        },
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset("asset/images/bg.svg", fit: BoxFit.fill),
          Column(
            children: [
              Spacer(flex: 2),
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
              Spacer(),
              // Container(
              //   height: 50,
              //   width: 120,
              //   decoration: BoxDecoration(
              //       color: Colors.blue,
              //       borderRadius: BorderRadius.circular(20)),
              //   child: ElevatedButton(
              //     onPressed: () {
              //       ResetDataOfApp();
              //       Navigator.pushNamed(context, '/levels');
              //     },
              //     child: Icon(Icons.arrow_back),
              //   ),
              // ),
              Spacer(flex: 1),

// decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(25),
//       ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                padding: EdgeInsets.all(kDefaultPadding),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  children: [
                    SizedBox(height: kDefaultPadding / 2),
                    Container(height: 230, child: buildVerticalListView())
                  ],
                ),
              ),
              Spacer(),
              Container(
                width: 300,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: kPrimaryGradient,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: TextButton(
                  onPressed: () {
                    ResetDataOfApp();
                    Navigator.pushNamed(context, '/levels');
                  },
                  child: Text(
                    'Main menu',
                    style: Theme.of(context)
                        .textTheme
                        .button
                        ?.copyWith(color: Colors.black),
                  ),
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
      // print(words[i]);
      if (answers[i] == words[i]) {
        setState(() {
          score++;
        });
      }
    }
  }

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // Fluttter show the back button automatically
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Container(
            height: 20,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: kSecondaryGradient,
              // color: Color(0xFF1C2242),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: TextButton(
                onPressed: () {
                  incrementCounter();
                  calculateScore();
                  Navigator.pushNamed(context, '/score');
                  print("ended");
                },
                child: Text(
                  "End",
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                )),
          ),
        ],
      ),

      body: Stack(fit: StackFit.expand, children: [
        SvgPicture.asset("asset/images/bg_light.svg", fit: BoxFit.fill),
        SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              LoopOverWords2(_counter),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        // gradient: kSecondaryGradient,
                        color: Color(0xFF1C2242),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        boxShadow: [
                          new BoxShadow(
                            offset: const Offset(
                              2.0,
                              2.0,
                            ),
                            color: Colors.black45,
                            blurRadius: 20.0,
                          ),
                        ]),
                    child: TextButton(
                      onPressed: decrementCounter,
                      child: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 100,
                    decoration: BoxDecoration(
                        // gradient: kSecondaryGradient,
                        color: Color(0xFF1C2242),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        boxShadow: [
                          new BoxShadow(
                            offset: const Offset(
                              2.0,
                              2.0,
                            ),
                            color: Colors.black45,
                            blurRadius: 20.0,
                          ),
                        ]),
                    child: TextButton(
                      onPressed: incrementCounter,
                      child: Icon(Icons.arrow_forward, color: Colors.white),
                    ),
                  ),
                ],
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     incrementCounter();
              //     calculateScore();
              //     // ResetDataOfApp();
              //     Navigator.pushNamed(context, '/score');
              //     print("ended");
              //   },
              //   child: Text("end"),
              // ),
            ]))
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
        Container(
          height: 10,
        ),
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
                style: TextStyle(color: Colors.white),
                controller: controlerOfTheAnsField,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFF1C2341),
                  hintText: "Type your answer here",
                  hintStyle: TextStyle(fontSize: 20.0, color: Colors.white24),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  labelText: 'Answer',
                  labelStyle: TextStyle(fontSize: 20.0, color: Colors.white24),
                  prefixIcon: Icon(
                    Icons.question_answer,
                    color: Colors.white30,
                  ),
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
                    // print(answers);
                    // print(controlerOfTheAnsField.text);
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
            child: Opacity(
              opacity: 0.9,
              child: const Text(
                "Speak",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
            style: ButtonStyle(
              shape: MaterialStateProperty.all(CircleBorder()),
              padding: MaterialStateProperty.all(EdgeInsets.all(50)),
              backgroundColor: MaterialStateProperty.all(Color(0xFF1C2341)),
            ),
          ),
        ],
      ),
    );
  }
}
