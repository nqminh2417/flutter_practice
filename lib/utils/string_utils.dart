import 'dart:math';

import 'constants.dart';

class StringUtils {
  static String capitalizeFirstLetter(String text) {
    // Capitalize the first letter of the text
    if (text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1);
  }

  static String capitalizeEveryWord(String text) {
    if (text.isEmpty) {
      return text;
    }

    final List<String> words = text.split(' ');
    final capitalizedWords = words.map((word) {
      final firstLetter = word.substring(0, 1).toUpperCase();
      final remainingLetters = word.substring(1).toLowerCase();
      return '$firstLetter$remainingLetters';
    });

    return capitalizedWords.join(' ');
  }

  static String formatThemeOption(ThemeOption option) {
    final formattedText = option.toString().split('.').last;

    // Add custom formatting based on the enum value
    switch (option) {
      case ThemeOption.dimTwitter:
        return 'Dim Twitter';
      case ThemeOption.nightTelegram:
        return 'Night Telegram';
      default:
        // Remove "ThemeOption." prefix and return the formatted text
        return formattedText;
    }
  }

  static String formatNumberToShort(number) {
    int value = (number is int) ? number : int.tryParse(number) ?? 0;
    const suffixes = ['K', 'M', 'B', 'T'];

    if (value <= 0) return '0';

    final logValue = log(value) / log(10);
    final exp = logValue ~/ 3;
    final shortValue = (value / pow(1000, exp)).toStringAsFixed(2);

    return '$shortValue${suffixes[exp - 1]}';
  }
}
