import 'package:flutter/material.dart';

class QMButton extends StatelessWidget {
  final String text;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final bool isDisabled;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
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
  final double leadingIconPaddingLeft;
  final double leadingIconPaddingRight;
  final double trailingIconPaddingLeft;
  final double trailingIconPaddingRight;

  /// The [text] parameter must not be null.
  ///
  /// If you want to display borderColor and borderWidth, then borderStyle must be set to BorderStyle.solid
  const QMButton({
    super.key,
    required this.text,
    this.isDisabled = false,
    this.onPressed,
    this.onLongPress,
    this.leadingIcon,
    this.trailingIcon,
    this.width = 120,
    this.height = 40,
    this.iconSize = 24,
    this.borderRadius = 4,
    this.borderWidth = 1,
    this.borderColor,
    this.borderStyle = BorderStyle.none,
    this.textStyle = const TextStyle(),
    this.shadowColor,
    this.backgroundColor,
    this.foregroundColor,
    this.leadingIconPaddingLeft = 8,
    this.leadingIconPaddingRight = 0,
    this.trailingIconPaddingLeft = 0,
    this.trailingIconPaddingRight = 8,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        onLongPress: isDisabled ? null : onLongPress,
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
              Padding(
                padding: EdgeInsets.only(
                    left: leadingIconPaddingLeft,
                    right: leadingIconPaddingRight),
                child: Icon(leadingIcon!, size: iconSize),
              ),
            ],
            Expanded(
                child: Center(
                    child: Text(text, style: textStyle))), // Set the text style
            if (trailingIcon != null) ...[
              Padding(
                padding: EdgeInsets.only(
                    left: trailingIconPaddingLeft,
                    right: trailingIconPaddingRight),
                child: Icon(trailingIcon!, size: iconSize),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
