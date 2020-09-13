class FormatHelper {
  static String formatMovieValues(int value) {
    if (value == 0) {
      return "-";
    } else if (value < 999999) {
      return "${(value / 1000).toStringAsFixed(0)} mil (USD)";
    } else if (value < 999999999) {
      return "${(value / 1000000).toStringAsFixed(0)} milhões (USD)";
    } else {
      return "${(value / 1000000000).toStringAsFixed(0)} bilhões (USD)";
    }
  }
}
