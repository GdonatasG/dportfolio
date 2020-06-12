import 'app_data_export.dart';
import 'package:flutter/material.dart';

/// Contains some useful methods for build contexts.
extension AppDataExtension on BuildContext {
  /// Returns the string associated to the specified key using EzLocalization.
  String getString(String key, [dynamic args]) =>
      AppLocalizations.of(this).get(key, args);
}
