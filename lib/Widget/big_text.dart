import 'package:flutter/cupertino.dart';

class BigText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;

  BigText(
      {Key? key,
        this.color = const Color(0xFF332b2b),
        required this.text,
        this.overflow = TextOverflow.ellipsis,
        this.size = 20})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: size,
        fontFamily: 'Roboto',
      ),
    );
  }
}
