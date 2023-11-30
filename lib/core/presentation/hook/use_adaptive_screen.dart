import 'package:flutter_hooks/flutter_hooks.dart';

import '../extensions/app_dimension.dart';

export '../extensions/app_dimension.dart'
    show
        ResponsiveDoubleExtension,
        ResponsiveEdgeInsetsExtension,
        ResponsiveSizeBoxExtension;

void useAdaptiveScreen() {
  final context = useContext();
  AppDimension.of(context);
}
