import 'package:intl/intl.dart';

class HumanFormats {
  static String number(double number) {
    final formatedNumber =
        NumberFormat.compactCurrency(decimalDigits: 2, symbol: 'S/.', locale: 'en')
            .format(number);

    return formatedNumber;
  }
}
