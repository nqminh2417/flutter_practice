import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/string_utils.dart';

class RadioButtonRight extends StatelessWidget {
  final ThemeOption themeOption;
  final ThemeOption selectedThemeOption;
  final ValueChanged<ThemeOption?> onChanged;
  const RadioButtonRight(
      {super.key,
      required this.themeOption,
      required this.selectedThemeOption,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(themeOption);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                StringUtils.capitalizeEveryWord(
                    StringUtils.formatThemeOption(themeOption)),
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
            Radio<ThemeOption>(
              value: themeOption,
              groupValue: selectedThemeOption,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
