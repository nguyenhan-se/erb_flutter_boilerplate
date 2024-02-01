import 'package:flutter/material.dart';

import 'demo_text_comp.dart';

class TabComp {
  final String title;
  final Widget child;

  TabComp({required this.title, required this.child});
}

final listCompTab = [
  TabComp(child: const DemoTextComp(), title: 'Text'),
];
