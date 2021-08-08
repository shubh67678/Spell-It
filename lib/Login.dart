import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_svg/svg.dart';

import 'LevelSelector.dart';
import 'main.dart';
import 'gsheetAPI.dart' as gsheet;
// import 'package:get/get.dart';
import 'constants.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();

  var dataToInsertInToExcel = {'name': '', 'email': ''};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset("asset/images/bg.svg", fit: BoxFit.fill),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(flex: 4), //2/6
                  Text(
                    "Let's Learn!",
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Please Login",
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: Colors.white60, fontWeight: FontWeight.bold),
                  ),
                  Spacer(flex: 1), //2/6

                  NameInputForm(nameController: nameController),
                  Container(
                    height: 16,
                  ),
                  EmailInputForm(emailController: emailController),
                  Spacer(flex: 1),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: kPrimaryGradient,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
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
                        'Lets Start!',
                        style: Theme.of(context)
                            .textTheme
                            .button
                            ?.copyWith(color: Colors.black),
                      ),
                    ),
                  ),

                  Spacer(flex: 3), // it will take 2/6 spaces
                ],
              ),
            ),
          ),
        ],
      ),
    );

    // return Scaffold(
    //   backgroundColor: Colors.white,
    //   appBar: AppBar(
    //     title: Text("Login Page"),
    //   ),
    //   body: Center(
    //     child: SingleChildScrollView(
    //       child: Center(
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           children: <Widget>[
    //             NameInputForm(nameController: nameController),
    //             EmailInputForm(emailController: emailController),
    //             Padding(
    //               padding: const EdgeInsets.all(10.0),
    //               child: Container(
    //                 height: 50,
    //                 width: 250,
    //                 decoration: BoxDecoration(
    //                     color: Colors.blue,
    //                     borderRadius: BorderRadius.circular(20)),
    //                 child: TextButton(
    //                   onPressed: () {
    //                     print("test");

    //                     if (emailController.text != null &&
    //                         EmailValidator.validate(emailController.text)) {
    //                       //email is valid now upload data to excel

    //                       dataToInsertInToExcel['name'] =
    //                           nameController.text.toString();

    //                       dataToInsertInToExcel['email'] =
    //                           emailController.text.toString();

    //                       sendData() async {
    //                         gsheet.insertDataToExcel(dataToInsertInToExcel);
    //                       }

    //                       sendData();
    //                       Navigator.pushNamed(context, '/levels');
    //                       print("in");
    //                     } else {
    //                       ScaffoldMessenger.of(context)
    //                         ..removeCurrentSnackBar()
    //                         ..showSnackBar(SnackBar(
    //                           content: Text('Please enter a valid email'),
    //                         ));
    //                     }
    //                   },
    //                   child: Text(
    //                     'Login',
    //                     style: TextStyle(color: Colors.white, fontSize: 25),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             InkWell(
    //               child: Container(
    //                 width: double.infinity,
    //                 alignment: Alignment.center,
    //                 padding: EdgeInsets.all(kDefaultPadding * 0.75), // 15
    //                 decoration: BoxDecoration(
    //                   gradient: kPrimaryGradient,
    //                   borderRadius: BorderRadius.all(Radius.circular(12)),
    //                 ),
    //                 child: Text(
    //                   "Lets Start Quiz",
    //                   style: Theme.of(context)
    //                       .textTheme
    //                       .button
    //                       ?.copyWith(color: Colors.black),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}

class NameInputForm extends StatelessWidget {
  const NameInputForm({
    Key? key,
    required this.nameController,
  }) : super(key: key);

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      controller: nameController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFF1C2341),
        hintText: "Full Name",
        hintStyle: TextStyle(fontSize: 20.0, color: Colors.white24),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        labelText: 'Full Name',
        labelStyle: TextStyle(fontSize: 20.0, color: Colors.white24),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.white30,
        ),
      ),
      autofillHints: [AutofillHints.email],
    );
  }
}

class EmailInputForm extends StatelessWidget {
  const EmailInputForm({
    Key? key,
    required this.emailController,
  }) : super(key: key);

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      controller: emailController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFF1C2341),
        hintText: 'Enter your emailId',
        hintStyle: TextStyle(fontSize: 20.0, color: Colors.white24),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        labelText: 'Email',
        labelStyle: TextStyle(fontSize: 20.0, color: Colors.white24),
        prefixIcon: Icon(
          Icons.mail,
          color: Colors.white30,
        ),
        // border: OutlineInputBorder(),
      ),
    );
  }
}
