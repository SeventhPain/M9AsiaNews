import 'package:intl/intl.dart';
import 'package:m9_news/utils/constants.dart';

class Helpers {
  static String formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  static String getImageUrl(String path) {
    if (path.startsWith('http')) {
      return path;
    }
    return '${AppConstants.apiBaseUrl}/$path';
  }
}
