import 'package:flutter/material.dart';
import 'package:flutter_app_photo/localization/l10n.dart';

class LocalizeText {
  late String Function(S) _block;

  LocalizeText({required String Function(S) block}) {
    _block = block;
  }

  String getText(BuildContext context) {
    return _block(S.of(context));
  }
}
