import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
  print('--- Parse json from: $assetsPath');
  return rootBundle
      .loadString(assetsPath)
      .then((jsonStr) => jsonDecode(jsonStr));
}

var path = "asset/data.json";
getTheJsonData() async {
  var ans;
  Map<String, dynamic> dmap = await parseJsonFromAssets(path);
  parseJsonFromAssets(path).then((value) => ans = value);
  return dmap;
}
