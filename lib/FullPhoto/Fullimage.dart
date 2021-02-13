import 'package:flutter/material.dart';

class FullImage extends StatefulWidget {
  final img;

  const FullImage({Key key, this.img}) : super(key: key);
  @override
  _FullImageState createState() => _FullImageState();
}

class _FullImageState extends State<FullImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(widget.img))),
    );
  }
}
