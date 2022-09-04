enum WinningTexts { RECORD, PRIZE, NOTHING }

extension WinningTextsExtension on WinningTexts {
  String get message {
    switch (this) {
      case WinningTexts.NOTHING:
        return "Maybe next time!";
      case WinningTexts.PRIZE:
        return "Woo hoo! ,you have won a PRIZE!";
      case WinningTexts.RECORD:
        return "OMG, YOU JUST BROKE THE RECORD!";
      default:
        return "";
    }
  }
}
