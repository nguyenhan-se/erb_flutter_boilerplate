import 'package:flutter/material.dart';

import 'package:erb_flutter_boilerplate/core/presentation/hook/hook.dart';

import '_interface/base/app_exception.dart';
import 'app_exception_message.dart';

extension AppErrorExtension on Object {
  String errorMessage(BuildContext context) {
    final t = useI18n();
    final error = this;
    if (error is AppException) {
      return AppExceptionMessage.map(error, t);
    }
    return t.exception.unknownException;
  }
}
