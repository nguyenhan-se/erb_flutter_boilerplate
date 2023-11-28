import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:erb_flutter_boilerplate/i18n/i18n.dart';

StringsVi useI18n() {
  final context = useContext();

  return Translations.of(context);
}
