import 'dart:math';
import 'package:flutter/material.dart';

class ColorUtils {
  static Color getRandomColor({bool useARGB = false, bool useHSL = false}) {
    if (useARGB) {
      Random random = Random();
      return Color.fromARGB(
        255,
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
      );
    } else if (useHSL) {
      Random random = Random();
      final hue = random.nextDouble() * 360;
      final saturation = random.nextDouble();
      final lightness = random.nextDouble();
      return HSLColor.fromAHSL(1.0, hue, saturation, lightness).toColor();
    } else {
      return Color(Random().nextInt(0xFFFFFFFF)).withOpacity(1.0);
    }
  }

  static List<Color> getRandomColorList(int count,
      {bool useARGB = false, bool useHSL = false}) {
    List<Color> colors = [];
    for (int i = 0; i < count; i++) {
      colors.add(getRandomColor(useARGB: useARGB, useHSL: useHSL));
    }
    return colors;
  }

  static Color getRandomMaterialColor() {
    final random = Random();
    return Colors.primaries[random.nextInt(Colors.primaries.length)];
  }

  static String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0')}';
  }

  static Color getContrastColor(Color backgroundColor) {
    const threshold = 128;
    final double luminance = (0.299 * backgroundColor.red +
        0.587 * backgroundColor.green +
        0.114 * backgroundColor.blue);
    return luminance > threshold ? Colors.black : Colors.white;
  }
}
