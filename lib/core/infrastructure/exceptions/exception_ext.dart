import 'package:flutter/material.dart';

import 'package:erb_flutter_boilerplate/i18n/i18n.dart';

import '_interface/base/app_exception.dart';
import 'app_exception_message.dart';

extension AppErrorExtension on Object {
  String errorMessage(BuildContext context) {
    final t = context.translate;
    final error = this;
    if (error is AppException) {
      return AppExceptionMessage.map(error, t);
    }
    return t.exception.unknownException;
  }
}
