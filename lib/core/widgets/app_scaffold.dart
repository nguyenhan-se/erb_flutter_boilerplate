import 'package:flutter/material.dart';
import 'package:erb_shared/extensions.dart';
import 'package:app_constants/app_constants.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.body,
    this.appBar,
    this.floatingActionButton,
    this.drawer,
    this.backgroundColor,
    this.hideKeyboardWhenTouchOutside =
        AppSettings.hideKeyboardWhenTouchOutside,
    this.safeArea = AppSettings.safeArea,
    this.resizeToAvoidBottomInset = AppSettings.resizeToAvoidBottomInset,
    this.background,
    super.key,
  });

  final Widget body;
  final bool hideKeyboardWhenTouchOutside;
  final bool safeArea;
  final bool resizeToAvoidBottomInset;
  final PreferredSizeWidget? appBar;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final Widget? background;

  Widget _buildWrapperBackground(Widget child) {
    return background.isNotNull ? Stack(children: [background!, child]) : child;
  }

  Widget _buildSafeArea(Widget child) {
    return safeArea ? SafeArea(child: child) : child;
  }

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold(
      backgroundColor: backgroundColor,
      body: _buildWrapperBackground(_buildSafeArea(body)),
      appBar: appBar,
      drawer: drawer,
      floatingActionButton: floatingActionButton,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );

    return hideKeyboardWhenTouchOutside
        ? GestureDetector(
            onTap: () {
              final currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: scaffold,
          )
        : scaffold;
  }
}
