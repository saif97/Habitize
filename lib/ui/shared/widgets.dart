import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

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

Widget CCachedNetworkImage({String url, double yAligment}) {
  return CachedNetworkImage(
    imageUrl: url,
    placeholder: (context, url) => const CircularProgressIndicator(),
    errorWidget: (context, url, error) => Icon(Icons.error),
    height: UNSPLASH_IMAGE_HEIGHT,
    width: double.infinity,
    fit: BoxFit.fitWidth,
    alignment: Alignment(0, yAligment ?? 0),
  );
}
