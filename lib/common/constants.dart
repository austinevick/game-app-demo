import 'package:flutter/widgets.dart';

const primaryColor = Color(0xff155332);
const headingTextStyle = TextStyle(fontWeight: FontWeight.w700, fontSize: 16);

extension ColorExtension on String {
  toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}
