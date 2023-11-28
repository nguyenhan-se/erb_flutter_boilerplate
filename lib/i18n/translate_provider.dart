import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/features/app_settings/application/app_settings_service.dart';
import 'strings.g.dart';

final translateProvider = AutoDisposeProvider((ref) {
  final currentLanguage = ref.watch(currentLanguageProvider);
  final lang = currentLanguage ?? AppLocale.vi;

  return AppLocaleUtils.parseLocaleParts(
          languageCode: lang.languageCode, countryCode: lang.countryCode)
      .build();
});
