import 'package:flutter/material.dart';

class QMButton extends StatelessWidget {
  final String text;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final double iconSize;
  final double borderRadius;
  final double borderWidth;
  final Color? borderColor;
  final BorderStyle borderStyle;
  final TextStyle textStyle;
  final Color? shadowColor;
  final Color? backgroundColor;
  final Color? foregroundColor;

  /// The [text] parameter must not be null.
  ///
  /// If you want to display borderColor and borderWidth, then borderStyle must be set to BorderStyle.solid
  const QMButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.leadingIcon,
    this.trailingIcon,
    this.width = 120,
    this.height = 40,
    this.iconSize = 24,
    this.borderRadius = 10,
    this.borderWidth = 1,
    this.borderColor,
    this.borderStyle = BorderStyle.none,
    this.textStyle = const TextStyle(),
    this.shadowColor,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          side: BorderSide(
              width: borderWidth,
              color: borderColor ?? Colors.black,
              style: borderStyle),
          padding: EdgeInsets.zero,
          shadowColor: shadowColor,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor, // Change color both icon and text
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leadingIcon != null) ...[
              Icon(leadingIcon!, size: iconSize),
              const SizedBox(width: 8),
            ],
            Text(text, style: textStyle), // Set the text style
            if (trailingIcon != null) ...[
              const SizedBox(width: 8),
              Icon(trailingIcon!, size: iconSize),
            ],
          ],
        ),
      ),
    );
  }
}
