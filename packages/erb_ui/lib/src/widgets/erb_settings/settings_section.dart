import 'package:flutter/material.dart';

import 'settings_tile.dart';

class ERbSettingsSection extends StatelessWidget {
  const ERbSettingsSection({
    required this.tiles,
    this.margin,
    this.title,
    Key? key,
  }) : super(key: key);

  final List<ERbSettingsTile> tiles;
  final EdgeInsetsDirectional? margin;
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    final scaleFactor = MediaQuery.of(context).textScaler;

    final tileList = buildTileList();
    if (title == null) {
      return tileList;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(
            top: scaleFactor.scale(12),
            bottom: scaleFactor.scale(4),
            start: 24,
            end: 24,
          ),
          child: title!,
        ),
        Container(
          // color: Colors.white,
          child: tileList,
        ),
      ],
    );
  }

  Widget buildTileList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: tiles.length,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        final tile = tiles[index];

        return ERbSettingsTileAdditionalInfo(
          needToShowDivider: index != tiles.length - 1,
          child: tile,
        );
      },
    );
  }
}
