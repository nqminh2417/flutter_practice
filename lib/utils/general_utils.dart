class GeneralUtils {
  static bool returnTrueFalseValue(dynamic value) {
    if (value == null || value == false) {
      // Handle case null, empty, undefined, or false
      return false;
    } else if (value == true) {
      return true;
    } else if (value is String) {
      final lowerCaseValue = value.toLowerCase();
      if (lowerCaseValue == 'true' ||
          lowerCaseValue == '1' ||
          lowerCaseValue == 'y') {
        return true;
      } else if (lowerCaseValue == 'false' ||
          lowerCaseValue == '0' ||
          lowerCaseValue == 'n') {
        return false;
      }
    } else if (value is num) {
      if (value == 1) {
        return true;
      } else if (value == 0) {
        return false;
      }
    }
    return false; // Default case, return false
  }

  static bool returnTrueFalseValue2(dynamic value) {
    if (value == null || value == false) {
      // Handle case null, empty, undefined, or false
      return false;
    } else if (value == true) {
      return true;
    }

    switch (value.toString().toLowerCase()) {
      case "true":
      case "1":
      case "y":
        return true;
      case "false":
      case "0":
      case "n":
        return false;
      default:
        return false;
    }
  }
}
