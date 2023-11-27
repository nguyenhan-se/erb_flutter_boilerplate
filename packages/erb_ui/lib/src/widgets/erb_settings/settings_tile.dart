import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ERbSettingsTileType { simpleTile, switchTile, navigationTile }

class ERbSettingsTile extends StatelessWidget {
  ERbSettingsTile({
    required this.title,
    this.leading,
    this.trailing,
    this.value,
    this.description,
    this.onPressed,
    this.enabled = true,
    Key? key,
  }) : super(key: key) {
    onToggle = null;
    initialValue = false;
    activeSwitchColor = null;
    tileType = ERbSettingsTileType.simpleTile;
  }

  /// The widget at the beginning of the tile
  final Widget? leading;

  /// The Widget at the end of the tile
  final Widget? trailing;

  /// The widget at the center of the tile
  final Widget title;

  /// The widget at the bottom of the [title]
  final Widget? description;

  /// A function that is called by tap on a tile
  final Function(BuildContext context)? onPressed;

  late final Color? activeSwitchColor;
  late final Widget? value;
  late final Function(bool value)? onToggle;
  late final ERbSettingsTileType tileType;
  late final bool initialValue;
  late final bool enabled;

  ERbSettingsTile.navigation({
    this.leading,
    this.trailing,
    this.value,
    required this.title,
    this.description,
    this.onPressed,
    this.enabled = true,
    Key? key,
  }) : super(key: key) {
    onToggle = null;
    initialValue = false;
    activeSwitchColor = null;
    tileType = ERbSettingsTileType.navigationTile;
  }

  ERbSettingsTile.switchTile({
    required this.initialValue,
    required this.onToggle,
    this.activeSwitchColor,
    this.leading,
    this.trailing,
    required this.title,
    this.description,
    this.onPressed,
    this.enabled = true,
    Key? key,
  }) : super(key: key) {
    value = null;
    tileType = ERbSettingsTileType.switchTile;
  }

  @override
  Widget build(BuildContext context) {
    final additionalInfo = ERbSettingsTileAdditionalInfo.of(context);

    final scaleFactor = MediaQuery.of(context).textScaler;

    final cantShowAnimation = tileType == ERbSettingsTileType.switchTile
        ? onToggle == null && onPressed == null
        : onPressed == null;

    return IgnorePointer(
      ignoring: !enabled,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: cantShowAnimation
              ? null
              : () {
                  if (tileType == ERbSettingsTileType.switchTile) {
                    onToggle?.call(initialValue);
                  } else {
                    onPressed?.call(context);
                  }
                },
          highlightColor: const Color.fromARGB(255, 146, 144, 148),
          child: Row(
            children: [
              if (leading != null)
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: 12,
                    end: 12,
                    bottom: scaleFactor.scale(4),
                    top: scaleFactor.scale(4),
                  ),
                  child: IconTheme(
                    data: IconTheme.of(context).copyWith(
                      color: enabled
                          ? const Color.fromARGB(255, 70, 70, 70)
                          : const Color.fromARGB(255, 146, 144, 148),
                    ),
                    child: leading!,
                  ),
                ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(
                                top: scaleFactor.scale(12.5),
                                bottom: scaleFactor.scale(12.5),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  title,
                                  if (value != null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 2.0),
                                      child: value!,
                                    )
                                  else if (description != null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 2.0),
                                      child: description!,
                                    ),
                                ],
                              ),
                            ),
                          ),
                          buildTrailing(context: context),
                        ],
                      ),
                    ),
                    if (description == null && additionalInfo.needToShowDivider)
                      const Divider(
                        height: 0,
                        thickness: 0.7,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTrailing({
    required BuildContext context,
  }) {
    final scaleFactor = MediaQuery.of(context).textScaler;

    return Row(
      children: [
        if (trailing != null) trailing!,
        if (tileType == ERbSettingsTileType.switchTile)
          Switch(
            value: initialValue,
            onChanged: onToggle,
            activeColor: enabled
                ? activeSwitchColor
                : const Color.fromARGB(255, 146, 144, 148),
          ),
        if (tileType == ERbSettingsTileType.navigationTile && value != null)
          value!,
        if (tileType == ERbSettingsTileType.navigationTile)
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 6, end: 2),
            child: IconTheme(
              data: IconTheme.of(context).copyWith(
                color: enabled
                    ? const Color.fromARGB(255, 70, 70, 70)
                    : const Color.fromARGB(255, 146, 144, 148),
              ),
              child: Icon(
                CupertinoIcons.chevron_forward,
                size: scaleFactor.scale(18),
              ),
            ),
          ),
      ],
    );
  }
}

class ERbSettingsTileAdditionalInfo extends InheritedWidget {
  final bool needToShowDivider;

  const ERbSettingsTileAdditionalInfo({
    required this.needToShowDivider,
    required Widget child,
    super.key,
  }) : super(child: child);

  @override
  bool updateShouldNotify(ERbSettingsTileAdditionalInfo oldWidget) => true;

  static ERbSettingsTileAdditionalInfo of(BuildContext context) {
    final ERbSettingsTileAdditionalInfo? result = context
        .dependOnInheritedWidgetOfExactType<ERbSettingsTileAdditionalInfo>();
    // assert(result != null, 'No ERbSettingsTileAdditionalInfo found in context');
    return result ??
        const ERbSettingsTileAdditionalInfo(
          needToShowDivider: true,
          child: SizedBox(),
        );
  }
}
