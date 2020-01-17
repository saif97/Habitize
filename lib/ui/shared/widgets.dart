import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class CProgressIndecator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}

Future CFlushBar(context, String message, {bool isDelayed}) async {
  isDelayed ?? await Future.delayed(Duration(milliseconds: 500));
  Flushbar(
    message: message,
    duration: Duration(seconds: 2),
  )..show(context);
}
