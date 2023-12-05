import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:erb_flutter_boilerplate/i18n/i18n.dart';

// NOTE: returns a concrete type instead of abstraction
// https://github.com/slang-i18n/slang/issues/169
I18n useI18n() {
  final context = useContext();

  return I18n.of(context);
}
