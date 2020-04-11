import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:rowing_log/app.dart';
import 'package:rowing_log/util/injector.dart';

void main() async {
  // debugPaintSizeEnabled = true;
  // debugPaintLayerBordersEnabled = true;
  Injector.injector.configure();
  runApp(RowingLogApp());
}