import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:app_constants/app_constants.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'i18n/i18n.dart';
import 'routes/routes.dart';
import 'core/features/notification/hooks/hooks.dart';
import 'core/presentation/providers/talker_log/talker_log.dart';
import 'core/features/app_settings/application/application.dart';

/// The main app widget at the root of the widget tree.
class App extends HookConsumerWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appSettings = ref.watch(appSettingsServiceProvider);
    final appRouter = ref.watch(appRouterProvider);
    final locale = ref.watch(currentLanguageProvider);

    useEffect(() {
      LocaleHelper.update(locale);

      return;
    }, [locale]);

    /// Set the fit size (fill in the screen size of the device in the design)
    /// https://www.paintcodeapp.com/news/ultimate-guide-to-iphone-resolutions
    ///    iPhone 2, 3, 4, 4s                => 3.5": 320 x 480 (points)
    ///    iPhone 5, 5s, 5C, SE (1st Gen)    => 4": 320 × 568 (points)
    ///    iPhone 6, 6s, 7, 8, SE (2st Gen)  => 4.7": 375 x 667 (points)
    ///    iPhone 6+, 6s+, 7+, 8+            => 5.5": 414 x 736 (points)
    ///    iPhone 11Pro, X, Xs               => 5.8": 375 x 812 (points)
    ///    iPhone 11, Xr                     => 6.1": 414 × 896 (points)
    ///    iPhone 11Pro Max, Xs Max          => 6.5": 414 x 896 (points)
    ///    iPhone 12 mini                    => 5.4": 375 x 812 (points)
    ///    iPhone 12, 12 Pro                 => 6.1": 390 x 844 (points)
    ///    iPhone 12 Pro Max                 => 6.7": 428 x 926 (points)
    final materialApp = _EagerInitialization(
      child: ScreenUtilInit(
        designSize: const Size(AppSettings.wdp, AppSettings.hdp),
        fontSizeResolver: (fontSize, instance) =>
            FontSizeResolvers.radius(fontSize, instance),
        ensureScreenSize: true,
        builder: (BuildContext context, child) {
          final textScaler = ScreenUtil().scaleText;

          return MaterialApp.router(
            builder: (context, child) {
              final MediaQueryData data = MediaQuery.of(context);
              // NOTE: global text scaler, no need to .sp
              return MediaQuery(
                data: data.copyWith(textScaler: TextScaler.linear(textScaler)),
                child: child ?? const SizedBox.shrink(),
              );
            },
            title: AppSettings.appTitle,
            theme: ref.watch(lightThemeProvider).themeData,
            darkTheme: ref.watch(darkThemeProvider).themeData,
            themeMode: ref.watch(currentAppThemeModeProvider),
            routerConfig: appRouter.config(
              // reevaluateListenable:
              //     ref.read(appRouterReevaluateListenableProvider),
              navigatorObservers: () => [
                RouterObserver(
                  talker: ref.watch(talkerProvider),
                  settings: const TalkerRouterObserverSettings(
                    enabled: LogSettings.defaultEnableAutoRouteLog,
                    printDidPush: LogSettings.enablePrintDidPush,
                    printDidPop: LogSettings.enablePrintDidPop,
                    printDidReplace: LogSettings.enablePrintDidReplace,
                    printDidRemove: LogSettings.enablePrintDidRemove,
                    printDidInitTabRoute:
                        LogSettings.enablePrintDidInitTabRoute,
                    printDidChangeTabRoute:
                        LogSettings.enablePrintDidChangeTabRoute,
                  ),
                ),
              ],
            ),
            locale:
                TranslationProvider.of(context).flutterLocale, // use provider
            supportedLocales: AppLocaleUtils.supportedLocales,
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
          );
        },
      ),
    );

    final bannerEnabled = appSettings.bannerEnabled;
    if (bannerEnabled) {
      return FlavorBanner(
        child: materialApp,
      );
    }
    return materialApp;
  }
}

// NOTE: https://riverpod.dev/docs/essentials/eager_initialization
// Eagerly initialize providers by watching them.
// By using "watch", the provider will stay alive and not be disposed.
class _EagerInitialization extends HookConsumerWidget {
  const _EagerInitialization({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useForegroundAppNotification();

    return child;
  }
}
