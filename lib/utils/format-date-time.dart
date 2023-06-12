import 'package:intl/intl.dart';

List<String> formatDateTime(DateTime dt) {
  List<String> result = [];

  result.add(DateFormat.yMMMd().format(dt).toString());
  result.add(DateFormat.jm().format(dt));

  return result;
}
