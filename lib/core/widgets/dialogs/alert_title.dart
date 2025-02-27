import 'package:assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:erb_shared/extensions.dart';
import 'package:app_constants/app_constants.dart';

enum DialogType { success, error, warning, info }

const double iconSize = 68;

class AlertTitle extends StatelessWidget {
  const AlertTitle({
    super.key,
    this.title,
    this.dialogType,
    this.padding,
  });

  final String? title;
  final EdgeInsetsGeometry? padding;
  final DialogType? dialogType;

  Color? backgroundTopColor(ThemeData theme) {
    switch (dialogType) {
      case DialogType.success:
        return theme.colorScheme.tertiary;
      case DialogType.warning:
        return theme.colorScheme.secondary;
      case DialogType.info:
        return theme.colorScheme.primary;
      default:
        return theme.colorScheme.error;
    }
  }

  Color? titleColor(ThemeData theme) {
    switch (dialogType) {
      case DialogType.success:
        return theme.colorScheme.tertiary;
      case DialogType.warning:
        return theme.colorScheme.secondary;
      case DialogType.info:
        return theme.colorScheme.primary;
      default:
        return theme.colorScheme.error;
    }
  }

  Widget icon() {
    switch (dialogType) {
      case DialogType.success:
        return AppAssets.icons.dialogSuccess.svg(
          height: iconSize,
          width: iconSize,
          fit: BoxFit.contain,
        );
      case DialogType.error:
        return AppAssets.icons.dialogError.svg(
          height: iconSize,
          width: iconSize,
          fit: BoxFit.contain,
        );
      case DialogType.warning:
        return AppAssets.icons.dialogWarning.svg(
          height: iconSize,
          width: iconSize,
          fit: BoxFit.contain,
        );
      case DialogType.info:
        return AppAssets.icons.dialogInfo.svg(
          height: iconSize,
          width: iconSize,
          fit: BoxFit.contain,
        );
      default:
        return AppAssets.images.loading.image(
          height: iconSize,
          width: iconSize,
          fit: BoxFit.contain,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        dialogType.isNotNull
            ? Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: backgroundTopColor(theme),
                      borderRadius: BorderRadius.only(
                        topLeft: KRadius.r8.radius,
                        topRight: KRadius.r8.radius,
                      ),
                    ),
                    height: iconSize,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 34),
                      icon(),
                    ],
                  )
                ],
              )
            : const SizedBox.shrink(),
        if (title.isNotNullOrEmpty)
          Padding(
            padding: padding ?? KEdgeInsets.h16.size,
            child: Text(
              title ?? '',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: dialogType.isNotNull ? titleColor(theme) : null,
              ),
            ),
          ),
      ],
    );
  }
}
