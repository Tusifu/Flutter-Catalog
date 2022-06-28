class Functions {
  // Decode and add appropriate numbers to the code to eventually send as phone call
  String computeCodeToSend(String rawCode, aText, rText) {
    String tmp = "";
    for (int x = 0; x < rawCode.length; x++) {
      if (rawCode[x] == "N") {
        tmp += rText;
      } else if (rawCode[x] == "A") {
        tmp += aText;
      } else if (rawCode[x] == " ") {
        continue;
      } else if (rawCode[x] == "  ") {
        continue;
      } else {
        tmp += rawCode[x];
      }
    }

    return tmp;
  }
}
