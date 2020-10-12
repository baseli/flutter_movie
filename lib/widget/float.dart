import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FloatWidget extends StatefulWidget {

  @override
  _FloatWidgetState createState() => _FloatWidgetState();
}

class _FloatWidgetState extends State<FloatWidget> {
  Offset offset = Offset(100, 300);

  Offset _calOffset(Size size, Offset offset, Offset nextOffset) {
    double dx = 0;
    if (offset.dx + nextOffset.dx <= 0) {
      dx = 0;
    } else if (offset.dx + nextOffset.dx >= (size.width - 50)) {
      dx = size.width - 50;
    } else {
      dx = offset.dx + nextOffset.dx;
    }
    double dy = 0;
    if (offset.dy + nextOffset.dy >= (size.height - 100)) {
      dy = size.height - 100;
    } else if (offset.dy + nextOffset.dy <= kToolbarHeight) {
      dy = kToolbarHeight;
    } else {
      dy = offset.dy + nextOffset.dy;
    }
    return Offset(
      dx,
      dy,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: offset.dx,
      top: offset.dy,
      child: GestureDetector(
        onPanUpdate: (detail) {
          setState(() {
            offset = _calOffset(MediaQuery.of(context).size, offset, detail.delta);
          });
        },
        onPanEnd: (detail) {},
        child: Container(
          width: 50.0,
          height: 50.0,
          color: Colors.blueAccent,
          child: Text('我是打酱油的'),
        ),
      ),
    );
  }
}
