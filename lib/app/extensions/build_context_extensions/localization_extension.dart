import 'package:flutter/material.dart';

import '../../app.dart';

extension ContextExtension on BuildContext {
  AppLocalizations? get l10n => AppLocalizations.of(this);
}
