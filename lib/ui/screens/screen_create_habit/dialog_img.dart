import 'package:Streak/ui/shared/shared_wids.dart';
import 'package:flutter/material.dart';

class DialogAdjustUnsplashImg extends StatefulWidget {
  final String url;
  const DialogAdjustUnsplashImg(this.url);

  @override
  _DialogAdjustUnsplashImgState createState() => _DialogAdjustUnsplashImgState();
}

class _DialogAdjustUnsplashImgState extends State<DialogAdjustUnsplashImg> {
  double yAlignment = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: SizedBox(
        height: 200,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            GestureDetector(
              onVerticalDragUpdate: (update) => dragImage(update),
              child: SharedCachedNetworkImage(url: widget.url, yAlignment: yAlignment),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, yAlignment),
                  child: const Text("Apply"),
                ),
                ElevatedButton(
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
    final double dy = dragInfo.delta.dy;
    if (dy == 0) return;
    setState(() {
      yAlignment += -dy / 100;
      if (yAlignment < -1)
        yAlignment = -1;
      else if (yAlignment > 1) yAlignment = 1;
    });
  }
}
