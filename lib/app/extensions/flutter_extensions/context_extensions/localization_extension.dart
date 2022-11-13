import 'package:flutter/cupertino.dart';

import '../../../l10n/l10n.dart';

extension LocalizationExtension on BuildContext {
  AppLocalizations? get l10n => AppLocalizations.of(this);
}
