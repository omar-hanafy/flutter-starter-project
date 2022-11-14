import 'package:flutter/material.dart';

import 'context.dart';

extension PlatformExtension on BuildContext {
  bool get isMobile =>
      theme.platform == TargetPlatform.iOS ||
      theme.platform == TargetPlatform.android;

  bool get isDesktop =>
      theme.platform == TargetPlatform.macOS ||
      theme.platform == TargetPlatform.windows ||
      theme.platform == TargetPlatform.linux;
}
