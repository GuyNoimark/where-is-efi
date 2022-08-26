enum WinningTexts { RECORD, PRIZE, NOTHING }

extension WinningTextsExtension on WinningTexts {
  String get message {
    switch (this) {
      case WinningTexts.NOTHING:
        return "Maybe Next Time !";
      case WinningTexts.PRIZE:
        return "Woo hoo! , you have won a PRIZE!";
      case WinningTexts.RECORD:
        return "OMG, YOU JUST BROKE THE RECORD!";
      default:
        return "";
    }
  }
}
