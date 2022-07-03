import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  Color? color;
  String name;
  double? fontsize;
  FontWeight? fontWeight;
  TextAlign? textalign;
  TextWidget(
      {Key? key,
      this.color,
      required this.name,
      this.fontsize,
      this.textalign,
      this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      textAlign: textalign,
      style: TextStyle(
          color: color ?? Colors.black,
          fontSize: fontsize ?? 14,
          fontWeight: fontWeight ?? FontWeight.normal,
         ),
    );
  }
}

class TextWidgetBorder extends StatelessWidget {
  Color? color;
  Color? colorborder;
  String name;
  double? fontsize;
  FontWeight? fontWeight;
  TextWidgetBorder(
      {Key? key,
      this.color,
      required this.name,
      this.fontsize,
      this.colorborder,
      this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(
      children: [
        // The text border
        Text(
          name,
          style: TextStyle(
            fontSize: fontsize ?? 50,
            letterSpacing: 5,
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 3
              ..color = color ?? Colors.grey,
          ),
        ),

        Text(
          name,
          style: TextStyle(
            fontSize: fontsize ?? 50,
            letterSpacing: 5,
            fontWeight: FontWeight.bold,
            color: colorborder ?? Colors.black,
          ),
        ),
      ],
    ));
  }
}
