import 'package:flutter/material.dart';

class CProgressIndecator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

Future CFlushBar(BuildContext context, String message, {bool isDelayed}) async {
  isDelayed ?? await Future.delayed(const Duration(milliseconds: 500));

//  Flushbar(
//    message: message,
//    duration: const Duration(seconds: 2),
//  )..show(context);
}
