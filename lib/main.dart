import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_svg/svg.dart';

import 'LevelSelector.dart';
import 'constants.dart';
import 'Login.dart';

var words = [];
var answers = [''];
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start, //Cent
                  children: [
                    RichText(
                      text: TextSpan(
                        text: userAnswer.toString(),
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                            color: getTheRightColor(userAnswer, TrueAnswer)),
                      ),
                    ),
                    showCorrectAnswer(TrueAnswer, userAnswer),
                  ],
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

  Padding showCorrectAnswer(TrueAnswer, String userAnswer) {
    return TrueAnswer != userAnswer
        ? Padding(
            padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 0),
            child: TrueAnswer != userAnswer ? Text("$TrueAnswer") : Text(""),
          )
        : Padding(padding: const EdgeInsets.fromLTRB(0, 0, 0, 0));
  }

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

              Spacer(flex: 1),

              Container(
                margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                padding: EdgeInsets.all(kDefaultPadding),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // SizedBox(height: kDefaultPadding / 2),
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
  answers = [''];
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
  @override
  void initState() {
    super.initState();
    // NOTE: Calling this function here would crash the app.
    speak(words[_counter]);
  }

  var modOperator = words.length;
  calculateScore(int num_question_answered) {
    // if (num_question_answered == 0) {
    //   _counter++;
    //   print("asdasd");
    //   setState(() {
    //     score = 0;
    //   });
    //   return;
    // }
    print(num_question_answered);
    print(answers);
    score = 0;
    var length_words = num_question_answered;
    if (length_words < score) {
      length_words = num_question_answered;
    }
    for (int i = 0; i < length_words + 1; i++) {
      if (answers.length >= i) {
        print("overflow");
      }

      answers[i].toLowerCase();
      answers[i].replaceAll(new RegExp(r"\s+"), ""); // remove all spaces
      words[i].toLowerCase();
      words[i].replaceAll(new RegExp(r"\s+"), ""); // remove all spaces

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
    if (_counter == 9) {
      calculateScore(_counter);
      Navigator.pushNamed(context, '/score');
      print("ended");
    }
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

  var wordNum = _counter + 1;

  final FlutterTts flutterTts = FlutterTts();

  speak(String to_speak) async {
    await flutterTts.setVolume(1);
    await flutterTts.speak(to_speak);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   // Fluttter show the back button automatically
      //   iconTheme:
      //       IconThemeData(color: Colors.white54), //change your color here
      //   backgroundColor: Colors.transparent,
      //   title: Text(""),
      //   elevation: 0,
      //   actions: [],
      // ),

      body: Stack(fit: StackFit.expand, children: [
        SvgPicture.asset("asset/images/bg_light.svg", fit: BoxFit.fill),
        SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Container(
            constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Spacer(),
              Center(
                child: Text(
                  "Word: ${_counter + 1} / 10",
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      ?.copyWith(color: kSecondaryColor),
                ),
              ),
              Spacer(),
              LoopOverWords2(_counter),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 130,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 20,
                            ),
                            Text(
                              "Back",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            )
                          ],
                        )),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 130,
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
                      onPressed: () {
                        incrementCounter();
                        if (answers.length <= _counter) {
                          print("inasd");
                          answers.add('');
                        }
                        speak(words[_counter]);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Next",
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      // gradient: kSecondaryGradient,
                      color: Color(0xFF1C2242),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: SizedBox(
                      width: 150,
                      child: TextButton(
                          onPressed: () {
                            calculateScore(_counter);
                            incrementCounter();
                            Navigator.pushNamed(context, '/score');
                            print("ended");
                          },
                          child: Text(
                            "End Session",
                            style: TextStyle(
                              color: Colors.white70,
                            ),
                          )),
                    ),
                  )
                ],
              ),
              Spacer(),
            ]),
          ),
        ))
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
                  // fillColor: Color(),
                  hintStyle: TextStyle(fontSize: 20.0, color: Colors.white24),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide:
                        BorderSide(color: Color(0xFF00CBC6), width: 2.0),
                  ),

                  labelText: 'Type your answer here',
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

                    answers[widget.wordIndex] = str;
                    // print(answers);
                    // print(controlerOfTheAnsField.text);
                  });
                }),
          ),
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
    // print(await flutterTts.getVoices);

    await flutterTts.setVolume(1);
    await flutterTts.setLanguage("en-US");
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
              speak(this.wordToSpeak);
            },
            child: Opacity(
              opacity: 0.9,
              child: const Text(
                "Dictate",
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
