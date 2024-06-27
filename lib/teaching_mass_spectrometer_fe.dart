import 'package:fluent_ui/fluent_ui.dart' hide Page;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:teaching_mass_spectrometer_2nd/generated/l10n.dart';
import 'package:teaching_mass_spectrometer_2nd/routes/router.dart';
import 'package:teaching_mass_spectrometer_2nd/theme.dart';

class TeachingMassSpectrometerFe extends StatelessWidget {
  TeachingMassSpectrometerFe({super.key});

  final _appTheme = AppTheme();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _appTheme,
      builder: (context, child) {
        final appTheme = context.watch<AppTheme>();

        return FluentApp.router(
          // title: 'TeachingMassSpectrometerFe',
          onGenerateTitle: (context) => TMSLocalizations.of(context).appTitle,
          themeMode: appTheme.mode,
          debugShowCheckedModeBanner: false,
          color: appTheme.color,
          darkTheme: FluentThemeData(
            brightness: Brightness.dark,
            accentColor: appTheme.color,
            visualDensity: VisualDensity.standard,
            focusTheme: FocusThemeData(
              glowFactor: is10footScreen(context) ? 2.0 : 0.0,
            ),
          ),
          theme: FluentThemeData(
            accentColor: appTheme.color,
            visualDensity: VisualDensity.standard,
            focusTheme: FocusThemeData(
              glowFactor: is10footScreen(context) ? 2.0 : 0.0,
            ),
          ),
          locale: appTheme.locale,

          /// 不需要设置supportedLocales，默认使用FluentLocalizations.supportedLocales
          localizationsDelegates: const [
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            FluentLocalizations.delegate,
            TMSLocalizations.delegate,
          ],

          /// 当用户选择未配置的语言时，默认显示英语
          localeListResolutionCallback: (locales, supportedLocales) {
            if (locales == null) return const Locale.fromSubtags(languageCode: 'en');
            for (Locale locale in locales) {
              if (TMSLocalizations.delegate.supportedLocales.contains(locale)) return locale;
            }
            return const Locale.fromSubtags(languageCode: 'en');
          },
          builder: (context, child) {
            return Directionality(
              textDirection: appTheme.textDirection,
              child: NavigationPaneTheme(
                data: NavigationPaneThemeData(
                  backgroundColor: appTheme.windowEffect !=
                          flutter_acrylic.WindowEffect.disabled
                      ? Colors.transparent
                      : null,
                ),
                child: child!,
              ),
            );
          },
          routeInformationParser: router.routeInformationParser,
          routeInformationProvider: router.routeInformationProvider,
          routerDelegate: router.routerDelegate,
        );
      },
    );
  }
}
