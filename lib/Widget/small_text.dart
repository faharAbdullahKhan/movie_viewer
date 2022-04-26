import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double height;
  TextOverflow overflow;

  SmallText(
      {Key? key,
        this.color = Colors.black,
        required this.text,
        this.overflow = TextOverflow.ellipsis,
        this.height = 1.2,
        this.size = 12})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(
          color: color,
          // fontWeight: FontWeight.w400,
          fontSize: size,
          fontFamily: 'Roboto',
          height: height
      ),
    );
  }
}
