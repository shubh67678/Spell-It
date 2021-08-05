import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';

class text_to_voice extends StatefulWidget {
  @override
  _text_to_voiceState createState() => _text_to_voiceState();
}

class _text_to_voiceState extends State<text_to_voice> {
  final FlutterTts flutterTts = FlutterTts();
  TextEditingController text_to_convert = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    speak(String to_speak) async {
      print(await flutterTts.getLanguages);
      print(await flutterTts.getVoices);
      await flutterTts.setVolume(1);
      await flutterTts.speak(to_speak);
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Text to Voice',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(
                    1.0,
                  ),
                  fontSize: 20)),
        ),
        body: Center(
          child: Container(
              child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: TextField(
                  controller: text_to_convert,
                  decoration: InputDecoration(
                    hintText: "Enter letters",
                    border: OutlineInputBorder(
                        // borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
              ),
              RaisedButton(
                child: Text("Speak"),
                onPressed: () =>
                    speak(text_to_convert.text.toString().toLowerCase()),
              ),
            ],
          )),
        ));
  }
}
