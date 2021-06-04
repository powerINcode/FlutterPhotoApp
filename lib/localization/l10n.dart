// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Photo gallery`
  String get galleryTitle {
    return Intl.message(
      'Photo gallery',
      name: 'galleryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Make photo`
  String get buttonMakePhoto {
    return Intl.message(
      'Make photo',
      name: 'buttonMakePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Make photo`
  String get makePhotoTitle {
    return Intl.message(
      'Make photo',
      name: 'makePhotoTitle',
      desc: '',
      args: [],
    );
  }

  /// `Type here photo name...`
  String get makePhotoHint {
    return Intl.message(
      'Type here photo name...',
      name: 'makePhotoHint',
      desc: '',
      args: [],
    );
  }

  /// `Please make photo first`
  String get makePhotoErrorPhotoEmpty {
    return Intl.message(
      'Please make photo first',
      name: 'makePhotoErrorPhotoEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Name can't be empty`
  String get makePhotoErrorNameEmpty {
    return Intl.message(
      'Name can\'t be empty',
      name: 'makePhotoErrorNameEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Save photo`
  String get buttonSavePhoto {
    return Intl.message(
      'Save photo',
      name: 'buttonSavePhoto',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
