import 'package:candystore/components/l10n/app_locale.dart';
import 'package:flutter/cupertino.dart';

extension LocalContextX on BuildContext {
  AppLocale get locale => AppLocale.of(this)!;
}
