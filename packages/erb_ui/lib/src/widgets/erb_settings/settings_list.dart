import 'package:flutter/material.dart';

import 'settings_section.dart';

class ERbSettingsList extends StatelessWidget {
  const ERbSettingsList({
    required this.sections,
    this.shrinkWrap = false,
    this.physics,
    this.contentPadding,
    Key? key,
  }) : super(key: key);

  final bool shrinkWrap;
  final List<ERbSettingsSection> sections;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Theme.of(context).colorScheme.onSurface,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: ListView.builder(
        physics: physics,
        shrinkWrap: shrinkWrap,
        itemCount: sections.length,
        padding: contentPadding ?? calculateDefaultPadding(context),
        itemBuilder: (BuildContext context, int index) {
          return sections[index];
        },
      ),
    );
  }

  EdgeInsets calculateDefaultPadding(BuildContext context) {
    if (MediaQuery.of(context).size.width > 810) {
      double padding = (MediaQuery.of(context).size.width - 810) / 2;
      return EdgeInsets.symmetric(
        horizontal: padding,
      );
    } else {
      return const EdgeInsets.symmetric(vertical: 0);
    }
  }
}
