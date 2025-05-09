import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  ThemeData getTheme() {
    return Theme.of(this);
  }

  FocusScopeNode unFocus() {
    return FocusScope.of(this);
  }

  void hideKeyBoard(){
    return FocusScope.of(this).requestFocus(FocusNode());
  }
}
