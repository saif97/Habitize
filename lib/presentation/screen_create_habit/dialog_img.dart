import 'package:flutter/material.dart';

import '../../ui/shared/widgets.dart';

class DialogAdgustUnsplashImg extends StatefulWidget {
  String url;
  DialogAdgustUnsplashImg(this.url);

  @override
  _DialogAdgustUnsplashImgState createState() => _DialogAdgustUnsplashImgState();
}

class _DialogAdgustUnsplashImgState extends State<DialogAdgustUnsplashImg> {
  double yAlignment = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 200,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            GestureDetector(
              onVerticalDragUpdate: (update) => dragImage(update),
              child: CCachedNetworkImage(url: widget.url, yAligment: yAlignment),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  onPressed: () => Navigator.pop(context, yAlignment),
                  child: const Text("Apply"),
                ),
                RaisedButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text("Remove"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void dragImage(DragUpdateDetails dragInfo) {
    double dy = dragInfo.delta.dy;
    if (dy == 0) return;
    setState(() {
      yAlignment += -dy / 100;
      if (yAlignment < -1)
        yAlignment = -1;
      else if (yAlignment > 1) yAlignment = 1;
    });
  }
}
