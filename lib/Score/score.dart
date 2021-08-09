// import 'package:flutter/material.dart';

// import 'package:myapp/constants.dart';

// class ScorePage extends StatelessWidget {
//   const ScorePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           // SvgPicture.asset("asset/images/bg.svg", fit: BoxFit.fill),
//           Column(
//             children: [
//               Spacer(flex: 3),
//               Text(
//                 "Score",
//                 style: Theme.of(context)
//                     .textTheme
//                     .headline3
//                     ?.copyWith(color: kSecondaryColor),
//               ),
//               Spacer(),
//               Text(
//                 "${score}/${_counter + 1}",
//                 style: Theme.of(context)
//                     .textTheme
//                     .headline4
//                     ?.copyWith(color: kSecondaryColor),
//               ),
//               Spacer(flex: 3),
//               Container(
//                 height: 50,
//                 width: 120,
//                 decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(20)),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     ResetDataOfApp();
//                     Navigator.pushNamed(context, '/levels');
//                   },
//                   child: Icon(Icons.arrow_back),
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
