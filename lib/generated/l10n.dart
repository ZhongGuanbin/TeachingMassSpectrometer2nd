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

class TMSLocalizations {
  TMSLocalizations();

  static TMSLocalizations? _current;

  static TMSLocalizations get current {
    assert(_current != null,
        'No instance of TMSLocalizations was loaded. Try to initialize the TMSLocalizations delegate before accessing TMSLocalizations.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<TMSLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = TMSLocalizations();
      TMSLocalizations._current = instance;

      return instance;
    });
  }

  static TMSLocalizations of(BuildContext context) {
    final instance = TMSLocalizations.maybeOf(context);
    assert(instance != null,
        'No instance of TMSLocalizations present in the widget tree. Did you add TMSLocalizations.delegate in localizationsDelegates?');
    return instance!;
  }

  static TMSLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<TMSLocalizations>(context, TMSLocalizations);
  }

  /// `TeachingMassSpectrometer`
  String get appTitle {
    return Intl.message(
      'TeachingMassSpectrometer',
      name: 'appTitle',
      desc: 'Title for the TeachingMassSpectrometer application',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<TMSLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<TMSLocalizations> load(Locale locale) => TMSLocalizations.load(locale);
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
