import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

import 'LevelSelector.dart';
import 'main.dart';
import 'gsheetAPI.dart' as gsheet;
// import 'package:get/get.dart';

class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  bool isValidEmail(var inputString) {
    if (inputString == null) {
      return false;
    }
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(inputString);
  }

  var dataToInsertInToExcel = {'name': '', 'email': ''};
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
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      hintText: 'Enter your full name',
                      prefixIcon: Icon(Icons.person),
                    ),
                    autofillHints: [AutofillHints.email],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: emailController,
                    // validator: (email) =>

                    //         ? 'Enter a valid email'
                    //         : null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter your emailId',
                      prefixIcon: Icon(Icons.mail),
                    ),
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
                        print("test");

                        if (emailController.text != null &&
                            EmailValidator.validate(emailController.text)) {
                          //email is valid now upload data to excel

                          dataToInsertInToExcel['name'] =
                              nameController.text.toString();

                          dataToInsertInToExcel['email'] =
                              emailController.text.toString();

                          sendData() async {
                            gsheet.insertDataToExcel(dataToInsertInToExcel);
                          }

                          sendData();
                          Navigator.pushNamed(context, '/levels');
                          print("in");
                        } else {
                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(SnackBar(
                              content: Text('Please enter a valid email'),
                            ));
                        }
                      },
                      child: Text(
                        'Login',
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
