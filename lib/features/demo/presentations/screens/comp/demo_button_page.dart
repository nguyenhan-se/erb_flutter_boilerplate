import 'package:app_constants/app_constants.dart';
import 'package:flutter/material.dart';

import 'package:erb_ui/widgets.dart';
import 'package:erb_shared/extensions.dart';

class DemoButtonPage extends StatelessWidget {
  const DemoButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ExamplePage(
      children: [
        WidgetItemEx('Size', _buildErbButtonSize()),
        WidgetItemEx('General', _buildErbButtonNormal()),
        WidgetItemEx('Icon', _buildErbButtonIcon()),
        WidgetItemEx('Disable', _buildErbButtonDisable()),
        WidgetItemEx('Shape', _buildErbButtonShape()),
        WidgetItemEx('Custom Style', _buildErbButtonCustomStyle()),
      ],
    );
  }

  Widget _buildErbButtonSize() => Wrap(
        spacing: 4.0,
        runSpacing: 4.0,
        children: [
          const ERbButton(
            text: 'Large Button',
            size: ERbButtonSize.large,
            type: ERbButtonType.fill,
            theme: ERbButtonTheme.primary,
            shape: ERbButtonShape.rectangle,
          ),
          KSizedBox.h4.size,
          const ERbButton(
            text: 'Medium Button',
            size: ERbButtonSize.medium,
            type: ERbButtonType.fill,
            theme: ERbButtonTheme.primary,
            shape: ERbButtonShape.rectangle,
          ),
          KSizedBox.h4.size,
          const ERbButton(
            text: 'Small Button',
            size: ERbButtonSize.small,
            type: ERbButtonType.fill,
            theme: ERbButtonTheme.primary,
            shape: ERbButtonShape.rectangle,
          ),
          KSizedBox.h4.size,
          const ERbButton(
            text: 'Extra Small Button',
            size: ERbButtonSize.extraSmall,
            type: ERbButtonType.fill,
            theme: ERbButtonTheme.primary,
            shape: ERbButtonShape.rectangle,
          ),
        ],
      );

  Widget _buildErbButtonNormal() => Wrap(
        spacing: 4.0,
        runSpacing: 4.0,
        children: [
          const ERbButton(
            text: 'Primary Filled Button',
            size: ERbButtonSize.large,
            type: ERbButtonType.fill,
            theme: ERbButtonTheme.primary,
            shape: ERbButtonShape.rectangle,
          ),
          KSizedBox.h4.size,
          const ERbButton(
            text: 'Light Filled Button',
            size: ERbButtonSize.large,
            type: ERbButtonType.fill,
            theme: ERbButtonTheme.light,
            shape: ERbButtonShape.rectangle,
          ),
          KSizedBox.h4.size,
          const ERbButton(
            text: 'Danger Filled Button',
            size: ERbButtonSize.large,
            type: ERbButtonType.fill,
            theme: ERbButtonTheme.danger,
            shape: ERbButtonShape.rectangle,
          ),
          KSizedBox.h4.size,
          const ERbButton(
            text: 'Outline Filled Button',
            size: ERbButtonSize.large,
            type: ERbButtonType.outline,
            theme: ERbButtonTheme.primary,
            shape: ERbButtonShape.rectangle,
          ),
          KSizedBox.h4.size,
          const ERbButton(
            text: 'Text Filled Button',
            size: ERbButtonSize.large,
            type: ERbButtonType.text,
            theme: ERbButtonTheme.primary,
            shape: ERbButtonShape.rectangle,
          ),
        ],
      );

  Widget _buildErbButtonIcon() => Wrap(
        spacing: 4.0,
        runSpacing: 4.0,
        children: [
          const ERbButton(
            text: 'Icon Right',
            iconRight: Icon(Icons.arrow_forward, color: Colors.white),
          ),
          KSizedBox.h4.size,
          const ERbButton(
            text: 'Icon Left',
            iconLeft: Icon(Icons.arrow_back, color: Colors.white),
          ),
          KSizedBox.h4.size,
          const ERbButton(
            text: 'Loading Button',
            iconLeft: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
          KSizedBox.h4.size,
          const ERbButton(
            iconLeft: Icon(Icons.bolt, color: Colors.white),
          ),
          KSizedBox.h4.size,
          const ERbButton(
            text: 'Icon Both',
            iconLeft: Icon(Icons.arrow_back, color: Colors.white),
            iconRight: Icon(Icons.arrow_forward, color: Colors.white),
          ),
        ],
      );

  Widget _buildErbButtonDisable() => const Wrap(
        spacing: 4.0,
        runSpacing: 4.0,
        children: [
          ERbButton(
            text: 'Primary Filled Button Disable',
            size: ERbButtonSize.large,
            type: ERbButtonType.fill,
            theme: ERbButtonTheme.primary,
            shape: ERbButtonShape.rectangle,
            disabled: true,
          ),
          ERbButton(
            text: 'Light Filled Button Disable',
            size: ERbButtonSize.large,
            type: ERbButtonType.fill,
            theme: ERbButtonTheme.light,
            shape: ERbButtonShape.rectangle,
            disabled: true,
          ),
          ERbButton(
            text: 'Danger Filled Button Disable',
            size: ERbButtonSize.large,
            type: ERbButtonType.fill,
            theme: ERbButtonTheme.danger,
            shape: ERbButtonShape.rectangle,
            disabled: true,
          ),
          ERbButton(
            text: 'Primary Outline Button Disable',
            size: ERbButtonSize.large,
            type: ERbButtonType.outline,
            theme: ERbButtonTheme.primary,
            shape: ERbButtonShape.rectangle,
            disabled: true,
          ),
          ERbButton(
            text: 'Light Outline Button Disable',
            size: ERbButtonSize.large,
            type: ERbButtonType.outline,
            theme: ERbButtonTheme.light,
            shape: ERbButtonShape.rectangle,
            disabled: true,
          ),
          ERbButton(
            text: 'Danger Outline Button Disable',
            size: ERbButtonSize.large,
            type: ERbButtonType.outline,
            theme: ERbButtonTheme.danger,
            shape: ERbButtonShape.rectangle,
            disabled: true,
          ),
          ERbButton(
            text: 'Primary Text Button Disable',
            size: ERbButtonSize.large,
            type: ERbButtonType.text,
            theme: ERbButtonTheme.primary,
            shape: ERbButtonShape.rectangle,
            disabled: true,
          ),
        ],
      );

  Widget _buildErbButtonShape() => const Wrap(
        spacing: 4.0,
        runSpacing: 4.0,
        children: [
          ERbButton(
            text: 'Rect Button',
            size: ERbButtonSize.large,
            type: ERbButtonType.fill,
            theme: ERbButtonTheme.primary,
            shape: ERbButtonShape.rectangle,
          ),
          ERbButton(
            text: 'Round Button',
            size: ERbButtonSize.large,
            type: ERbButtonType.fill,
            theme: ERbButtonTheme.primary,
            shape: ERbButtonShape.round,
          ),
          ERbButton(
            iconLeft: Icon(
              Icons.account_balance_rounded,
              color: Colors.white,
            ),
            size: ERbButtonSize.large,
            type: ERbButtonType.fill,
            theme: ERbButtonTheme.primary,
            shape: ERbButtonShape.square,
          ),
          ERbButton(
            iconLeft: Icon(
              Icons.account_balance_rounded,
              color: Colors.white,
            ),
            size: ERbButtonSize.large,
            type: ERbButtonType.fill,
            theme: ERbButtonTheme.primary,
            shape: ERbButtonShape.circle,
          ),
          ERbButton(
            text: 'Filled Button',
            size: ERbButtonSize.large,
            type: ERbButtonType.fill,
            theme: ERbButtonTheme.primary,
            shape: ERbButtonShape.filled,
          ),
        ],
      );

  Widget _buildErbButtonCustomStyle() => Wrap(
        spacing: 4.0,
        runSpacing: 4.0,
        children: [
          ERbButton(
            text: 'Rect Button',
            style: ERbButtonStyle(
              textColor: Colors.red,
              borderWidth: 3,
              boderColor: Colors.blue,
              backgroundColor: Colors.amber,
              radius: BorderRadius.all(KRadius.r32.radius),
            ),
          ),
        ],
      );
}

class ExamplePage extends StatelessWidget {
  const ExamplePage({
    this.children = const [],
    super.key,
  });

  final List<WidgetItemEx> children;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: children
            .map(
              (child) => Padding(
                padding: KEdgeInsets.v8.size,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      child.description,
                      style: context.textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    KSizedBox.h8.size,
                    child.child
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class WidgetItemEx {
  const WidgetItemEx(this.description, this.child);

  final String description;
  final Widget child;
}
