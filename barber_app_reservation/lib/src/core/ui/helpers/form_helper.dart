import 'package:flutter/material.dart';

void unfocus(BuildContext context) => FocusScope.of(context).unfocus();

// or

extension UnfocusExtension on BuildContext {
  void unfocus() => Focus.of(this).unfocus();
}
