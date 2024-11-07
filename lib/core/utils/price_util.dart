import 'package:intl/intl.dart';

class PriceUtil {
  static String formatPrice(int price) {
    final formatCurrency = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return formatCurrency.format(price);
  }
}
