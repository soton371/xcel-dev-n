
import 'package:intl/intl.dart';

const String EEE_DD_MMM_YYYY = "EEE, dd-MMM-yyyy";
const String DD_MMM_YYYY = "dd-MMM-yyyy";
class DateTimeUtils{

  String convertStringDateFormat(String dateStr, String newFormat) {
    if (dateStr == 'null' || dateStr.isEmpty) return "";
    try {
      return DateFormat(newFormat).format(DateTime.parse(dateStr));
    } on Exception {
      // only executed if error is of type Exception
      return "";
    } catch (error) {
      // executed for errors of all types other than Exception
      return "";
    }
  }
}