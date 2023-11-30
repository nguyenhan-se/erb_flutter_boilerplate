import 'package:flutter/material.dart';

import 'layout/erb_overflow_transform_box.dart';

Future<T?> showERbAlertDialog<T extends Object?>({
  required BuildContext context,
  Widget? title,
  Widget Function(BuildContext context)? content,
  EdgeInsetsGeometry titlePadding = EdgeInsets.zero,
  EdgeInsetsGeometry contentPadding = EdgeInsets.zero,
  ERbDialogData eRbDialogData = const ERbDialogData(),
  bool barrierDismissible = true,
}) async {
  final reformedContentPadding = EdgeInsets.symmetric(
    horizontal: contentPadding.horizontal / 2,
  ).copyWith(
    top: title == null ? contentPadding.vertical / 2 : 0,
    bottom: contentPadding.vertical / 2,
  );

  final horizontalActionPadding = eRbDialogData.actionsPadding.horizontal / 2;

  final reformedActionsPadding = EdgeInsets.symmetric(
    horizontal: horizontalActionPadding,
  ).copyWith(
    top: title == null && content == null
        ? eRbDialogData.actionsPadding.vertical / 2
        : 0,
    bottom: eRbDialogData.actionsPadding.vertical / 2,
  );

  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel: '',
    transitionBuilder: (context, a1, a2, widget) => Transform.scale(
      scale: a1.value,
      child: PopScope(
        //This prevent closing the dialog when pressing device's back button
        canPop: barrierDismissible,
        child: ERbOverflowTransformBox(
          transform: (constraints) =>
              ConstraintsTransformBox.widthUnconstrained(constraints),
          child: AlertDialog(
            title: title,
            titlePadding: titlePadding,
            content: content != null ? content(context) : null,
            contentPadding: reformedContentPadding,
            actions: eRbDialogData.actions?.call(context),
            actionsPadding: reformedActionsPadding,
            actionsAlignment: MainAxisAlignment.spaceAround,
            insetPadding: eRbDialogData.insetPadding,
            shape: eRbDialogData.shape,
            backgroundColor: eRbDialogData.backgroundColor,
          ),
        ),
      ),
    ),
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) =>
        const SizedBox(),
  );
}

class ERbDialogData {
  const ERbDialogData({
    this.actions,
    this.actionsPadding = EdgeInsets.zero,
    this.insetPadding = EdgeInsets.zero,
    this.maxWidth = 300,
    this.shape,
    this.backgroundColor,
  });

  final List<Widget>? Function(BuildContext context)? actions;
  final EdgeInsetsGeometry actionsPadding;
  final EdgeInsets insetPadding;
  final double maxWidth;
  final ShapeBorder? shape;
  final Color? backgroundColor;
}
