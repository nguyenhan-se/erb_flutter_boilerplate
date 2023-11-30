import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:app_constants/app_constants.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/features/app_settings/application/application.dart';
import 'core/presentation/providers/talker_log/talker_log.dart';
import 'i18n/i18n.dart';
import 'routes/routes.dart';

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
    final materialApp = ScreenUtilInit(
        designSize: const Size(AppSettings.wdp, AppSettings.hdp),
        builder: (BuildContext context, child) {
          ScreenUtil.init(context);
          return MaterialApp.router(
            title: AppSettings.appTitle,
            theme: ref.watch(lightThemeProvider).themeData,
            darkTheme: ref.watch(darkThemeProvider).themeData,
            themeMode: ref.watch(currentAppThemeModeProvider),
            routerConfig: appRouter.config(
              reevaluateListenable:
                  ref.watch(appRouterReevaluateListenableProvider),
              navigatorObservers: () => [
                TalkerRouteObserver(ref.watch(talkerProvider)),
              ],
            ),
            locale:
                TranslationProvider.of(context).flutterLocale, // use provider
            supportedLocales: AppLocaleUtils.supportedLocales,
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
          );
        });

    final bannerEnabled = appSettings.bannerEnabled;
    if (bannerEnabled) {
      return FlavorBanner(
        child: materialApp,
      );
    }
    return materialApp;
  }
}
