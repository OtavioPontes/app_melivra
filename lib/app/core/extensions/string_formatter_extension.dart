extension ExtensionFormatterString on String {
  String toPhoneNumberFormatted() {
    if (length != 11) return this;

    final String ddd = substring(0, 2);
    return '($ddd) ${this[2]} ${substring(3, 7)}-${substring(7)}';
  }
}
