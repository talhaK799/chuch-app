import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String currency(BuildContext context) {
  Locale locale = Localizations.localeOf(context);
  var format = NumberFormat.simpleCurrency(locale: locale.toString());
  return format.currencySymbol;
}
