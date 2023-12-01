import 'dart:async';

import 'package:erb_ui/widgets.dart';
import 'package:flutter/material.dart';
import 'package:app_constants/app_constants.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:erb_flutter_boilerplate/routes/routes.dart';
import 'package:erb_flutter_boilerplate/core/presentation/hook/hook.dart';

import 'alert_title.dart';

export 'alert_title.dart' show DialogType;

abstract class Dialogs {
  static final _defaultTitlePadding = KEdgeInsets.a16.size;

  static final _defaultContentPadding = KEdgeInsets.a16.size;

  static final _defaultMaterialInsetPadding = KEdgeInsets.a16.size;

  static RoundedRectangleBorder get _defaultMaterialShape =>
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8));

  static Future<T?> showLoadingDialog<T extends Object?>(
      BuildContext context) async {
    return showERbAlertDialog(
      context: context,
      barrierDismissible: false,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 28,
        horizontal: 20,
      ),
      content: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          KSizedBox.h16.size,
          HookConsumer(builder: (context, ref, child) {
            final t = useI18n();

            return Text(
              t.common.loading,
            );
          }),
        ],
      ),
      eRbDialogData: ERbDialogData(
        insetPadding: const EdgeInsets.symmetric(horizontal: 72),
        shape: _defaultMaterialShape,
      ),
    );
  }

  static Future<T?> showAlertDialog<T extends Object?>(
    BuildContext context, {
    String? title,
    String? labelButton,
    VoidCallback? onPressed,
    DialogType? dialogType,
    required String message,
  }) async {
    return showERbAlertDialog(
      context: context,
      title: AlertTitle(
        title: title ?? '',
        dialogType: dialogType,
      ),
      contentPadding: _defaultContentPadding,
      content: (context) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).dialogTheme.contentTextStyle,
        ),
      ),
      eRbDialogData: ERbDialogData(
        actions: (context) => [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: HookConsumer(builder: (context, ref, child) {
              final t = useI18n();

              return ERbElevatedButton(
                label: labelButton ?? t.common.ok,
                onPressed: () {
                  AutoRouter.of(context).pop();
                  onPressed?.call();
                },
              );
            }),
          )
        ],
        actionsPadding: _defaultTitlePadding,
        insetPadding: _defaultMaterialInsetPadding,
        shape: _defaultMaterialShape,
      ),
    );
  }

  static Future<T?> showGeneralDialog<T extends Object?>(
    BuildContext context, {
    Widget? title,
    Widget? content,
    List<Widget>? Function(BuildContext context)? actions,
  }) async {
    return showERbAlertDialog(
      context: context,
      titlePadding: _defaultTitlePadding,
      title: title,
      contentPadding: _defaultContentPadding,
      content: content != null
          ? (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [content],
              )
          : null,
      eRbDialogData: ERbDialogData(
        insetPadding: _defaultMaterialInsetPadding,
        shape: _defaultMaterialShape,
        actions: (context) => actions?.call(context),
        actionsPadding: _defaultTitlePadding,
      ),
    );
  }

  static Future<T?> showRequestPermissionDialog<T extends Object?>(
    BuildContext context, {
    String? title,
    required String reason,
    Function(BuildContext context)? onPositiveClick,
  }) async {
    return showERbAlertDialog(
      context: context,
      contentPadding: _defaultContentPadding,
      titlePadding: KEdgeInsets.v12.size,
      title: HookConsumer(
        builder: (context, ref, child) {
          final t = useI18n();
          return Center(child: Text(title ?? t.system.requestPermission));
        },
      ),
      content: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(reason),
        ],
      ),
      eRbDialogData: ERbDialogData(
        actionsPadding: KEdgeInsets.v8.size,
        actions: (context) => [
          HookConsumer(
            builder: (context, ref, child) {
              final t = useI18n();

              return TextButton(
                onPressed: () => AutoRouter.of(context).pop(),
                child: Text(t.common.cancel),
              );
            },
          ),
          ERbElevatedButton(
            enableGradient: true,
            onPressed: () {
              onPositiveClick?.call(context);
            },
            child: HookConsumer(
              builder: (context, ref, child) {
                final t = useI18n();

                return Text(t.system.openAppSetting);
              },
            ),
          ),
        ],
        shape: _defaultMaterialShape,
      ),
    );
  }
}
