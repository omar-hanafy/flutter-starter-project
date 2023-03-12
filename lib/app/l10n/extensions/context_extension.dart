import 'package:flutter/material.dart';

import '../l10n.dart';

extension ContextExtension on BuildContext {
  AppLocalizations? get l10n => AppLocalizations.of(this);
}
