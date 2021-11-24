import 'package:Streak/core/utils/locator.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'constants.dart';

var logger = Logger();

void utilsShowSnakeBar(BuildContext context, String title, String message) {
  Flushbar(
    title: title,
    message: message,
    duration: const Duration(seconds: 1),
  )..show(context);
}

void utilsShowPostFrameSnakeBar(BuildContext? context, String title, String msg) {
  if (context != null)
    WidgetsBinding.instance!.addPostFrameCallback((_) => utilsShowSnakeBar(context, title, msg));
  else
    logger.e("$title \n $msg");
}

Future delayedNavigatorReplaced(BuildContext context, String namedRout) async {
  await Future.delayed(const Duration(milliseconds: 500));
  await Navigator.pushReplacementNamed(context, namedRout);
}

void postFramePop<T>(BuildContext context, [T? result]) {
  WidgetsBinding.instance!.addPostFrameCallback((_) => Navigator.pop(context, result));
}

void postFrameReplacedNavigation(BuildContext context, String namedRout, {Object? args}) {
  WidgetsBinding.instance!
      .addPostFrameCallback((_) => Navigator.pushReplacementNamed(context, namedRout, arguments: args));
}

void postFrameAction(Function f) {
  WidgetsBinding.instance!.addPostFrameCallback((_) => f());
}

Widget CCircularProgressBar() => const Center(
      child: CircularProgressIndicator(),
    );

void showProgressDialog(BuildContext context) {
  WidgetsBinding.instance!.addPostFrameCallback((_) {
    final progress = ProgressHUD.of(context);
    progress!.show();
  });
}

void dismissProgressDialog(BuildContext context) {
  WidgetsBinding.instance!.addPostFrameCallback((_) {
    final progress = ProgressHUD.of(context);
    progress!.dismiss();
  });
}

Widget listOrEmptyMessage(List items, Widget ifNotEmpty) {
  if (items.isNotEmpty)
    return ifNotEmpty;
  else
    return const Center(child: Text('Nothing To show'));
}

class SharedVersionWid extends StatelessWidget {
  const SharedVersionWid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: Text(
        locator<PackageInfo>().version,
        style: const TextStyle(color: Colors.red, fontSize: 20),
      ),
    );
  }
}

Widget SharedCachedNetworkImage({required String url, double yAlignment = 0}) {
  return CachedNetworkImage(
    imageUrl: url,
    placeholder: (context, url) => const CircularProgressIndicator(),
    errorWidget: (context, url, error) => const Icon(Icons.error),
    height: UNSPLASH_IMAGE_HEIGHT,
    width: double.infinity,
    fit: BoxFit.fitWidth,
    alignment: Alignment(0, yAlignment),
  );
}
