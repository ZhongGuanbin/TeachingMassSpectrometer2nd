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

  /// `Yes`
  String get appConfirmButtonLabel {
    return Intl.message(
      'Yes',
      name: 'appConfirmButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get appAffirmButtonLabel {
    return Intl.message(
      'Yes',
      name: 'appAffirmButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get appCancelButtonLabel {
    return Intl.message(
      'Cancel',
      name: 'appCancelButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get appBackButtonLabel {
    return Intl.message(
      'Back',
      name: 'appBackButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get appDenyButtonLabel {
    return Intl.message(
      'No',
      name: 'appDenyButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm close`
  String get appCloseDialogTitle {
    return Intl.message(
      'Confirm close',
      name: 'appCloseDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to close this window?`
  String get appCloseDialogContent {
    return Intl.message(
      'Are you sure you want to close this window?',
      name: 'appCloseDialogContent',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get appSettings {
    return Intl.message(
      'Settings',
      name: 'appSettings',
      desc: '',
      args: [],
    );
  }

  /// `Theme Mode`
  String get themeMode {
    return Intl.message(
      'Theme Mode',
      name: 'themeMode',
      desc: '',
      args: [],
    );
  }

  /// `Navigation Pane Display Mode`
  String get navigationPaneDisplayMode {
    return Intl.message(
      'Navigation Pane Display Mode',
      name: 'navigationPaneDisplayMode',
      desc: '',
      args: [],
    );
  }

  /// `Navigation Indicator`
  String get navigationIndicator {
    return Intl.message(
      'Navigation Indicator',
      name: 'navigationIndicator',
      desc: '',
      args: [],
    );
  }

  /// `Accent Color`
  String get accentColor {
    return Intl.message(
      'Accent Color',
      name: 'accentColor',
      desc: '',
      args: [],
    );
  }

  /// `Window Transparency`
  String get windowTransparency {
    return Intl.message(
      'Window Transparency',
      name: 'windowTransparency',
      desc: '',
      args: [],
    );
  }

  /// `Text Direction`
  String get textDirection {
    return Intl.message(
      'Text Direction',
      name: 'textDirection',
      desc: '',
      args: [],
    );
  }

  /// `Locale`
  String get locale {
    return Intl.message(
      'Locale',
      name: 'locale',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<TMSLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
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
