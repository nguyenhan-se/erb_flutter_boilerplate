import 'package:app_constants/app_constants.dart';
import 'package:flutter/material.dart';

import 'package:erb_ui/widgets.dart';
import 'package:erb_shared/extensions.dart';

class DemoButtonComp extends StatelessWidget {
  const DemoButtonComp({super.key});

  @override
  Widget build(BuildContext context) {
    return ExamplePage(
      children: [
        WidgetItemEx('Size', _buildErbButtonSize()),
        WidgetItemEx('General', _buildErbButtonNormal()),
        WidgetItemEx('Icon', _buildErbButtonIcon()),
        WidgetItemEx('Child', _buildErbButtonChild()),
        WidgetItemEx('Disable', _buildErbButtonDisable()),
        WidgetItemEx('Shape', _buildErbButtonShape()),
        WidgetItemEx('Custom Style', _buildErbButtonCustomStyle()),
      ],
    );
  }

  Widget _buildErbButtonSize() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ERbButton(
            onTap: () {},
            text: 'Large',
            size: ERbButtonSize.large,
            type: ERbButtonType.fill,
            theme: ERbButtonTheme.primary,
            shape: ERbButtonShape.rectangle,
          ),
          KSizedBox.h4.size,
          ERbButton(
            onTap: () {},
            text: 'Medium',
            size: ERbButtonSize.medium,
            type: ERbButtonType.fill,
            theme: ERbButtonTheme.primary,
            shape: ERbButtonShape.rectangle,
          ),
          KSizedBox.h4.size,
          ERbButton(
            onTap: () {},
            text: 'Small',
            size: ERbButtonSize.small,
            type: ERbButtonType.fill,
            theme: ERbButtonTheme.primary,
            shape: ERbButtonShape.rectangle,
          ),
          KSizedBox.h4.size,
          ERbButton(
            onTap: () {},
            text: 'Extra Small',
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
          ERbButton(
            onTap: () {},
            text: 'Primary',
            size: ERbButtonSize.large,
            type: ERbButtonType.fill,
            theme: ERbButtonTheme.primary,
            shape: ERbButtonShape.rectangle,
          ),
          KSizedBox.h4.size,
          ERbButton(
            onTap: () {},
            text: 'Light',
            size: ERbButtonSize.large,
            type: ERbButtonType.fill,
            theme: ERbButtonTheme.light,
            shape: ERbButtonShape.rectangle,
          ),
          KSizedBox.h4.size,
          ERbButton(
            onTap: () {},
            text: 'Danger',
            size: ERbButtonSize.large,
            type: ERbButtonType.fill,
            theme: ERbButtonTheme.danger,
            shape: ERbButtonShape.rectangle,
          ),
          KSizedBox.h4.size,
          ERbButton(
            onTap: () {},
            text: 'Outline',
            size: ERbButtonSize.large,
            type: ERbButtonType.outline,
            theme: ERbButtonTheme.primary,
            shape: ERbButtonShape.rectangle,
          ),
          KSizedBox.h4.size,
          ERbButton(
            onTap: () {},
            text: 'Text',
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
          ERbButton(
            onTap: () {},
            text: 'Left',
            iconLeft: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          KSizedBox.h4.size,
          ERbButton(
            onTap: () {},
            text: 'Right',
            iconRight: const Icon(Icons.arrow_forward, color: Colors.white),
          ),
          KSizedBox.h4.size,
          ERbButton(
            onTap: () {},
            text: 'Loading',
            iconLeft: const CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
          KSizedBox.h4.size,
          ERbButton(
            onTap: () {},
            iconLeft: const Icon(Icons.bolt, color: Colors.white),
          ),
          KSizedBox.h4.size,
          ERbButton(
            onTap: () {},
            text: 'Icon Both',
            iconLeft: const Icon(Icons.arrow_back, color: Colors.white),
            iconRight: const Icon(Icons.arrow_forward, color: Colors.white),
          ),
        ],
      );

  Widget _buildErbButtonChild() => ERbButton(
        onTap: () {},
        child: Container(
          width: 50,
          height: 50,
          margin: KEdgeInsets.a8.size,
          color: Colors.red,
        ),
      );

  Widget _buildErbButtonDisable() => Wrap(
        runSpacing: 4.0,
        children: [
          ERbButton(
            onTap: () {},
            text: 'Primary Filled Button Disable',
            size: ERbButtonSize.large,
            type: ERbButtonType.fill,
            theme: ERbButtonTheme.primary,
            shape: ERbButtonShape.filled,
            disabled: true,
          ),
          ERbButton(
            onTap: () {},
            text: 'Light Filled Button Disable',
            size: ERbButtonSize.large,
            type: ERbButtonType.fill,
            theme: ERbButtonTheme.light,
            shape: ERbButtonShape.filled,
            disabled: true,
          ),
          ERbButton(
            onTap: () {},
            text: 'Danger Filled Button Disable',
            size: ERbButtonSize.large,
            type: ERbButtonType.fill,
            theme: ERbButtonTheme.danger,
            shape: ERbButtonShape.filled,
            disabled: true,
          ),
          ERbButton(
            onTap: () {},
            text: 'Primary Outline Button Disable',
            size: ERbButtonSize.large,
            type: ERbButtonType.outline,
            theme: ERbButtonTheme.primary,
            shape: ERbButtonShape.filled,
            disabled: true,
          ),
          ERbButton(
            onTap: () {},
            text: 'Light Outline Button Disable',
            size: ERbButtonSize.large,
            type: ERbButtonType.outline,
            theme: ERbButtonTheme.light,
            shape: ERbButtonShape.filled,
            disabled: true,
          ),
          ERbButton(
            onTap: () {},
            text: 'Danger Outline Button Disable',
            size: ERbButtonSize.large,
            type: ERbButtonType.outline,
            theme: ERbButtonTheme.danger,
            shape: ERbButtonShape.filled,
            disabled: true,
          ),
          ERbButton(
            onTap: () {},
            text: 'Primary Text Button Disable',
            size: ERbButtonSize.large,
            type: ERbButtonType.text,
            theme: ERbButtonTheme.primary,
            shape: ERbButtonShape.filled,
            disabled: true,
          ),
        ],
      );

  Widget _buildErbButtonShape() => Wrap(
        spacing: 4.0,
        runSpacing: 4.0,
        runAlignment: WrapAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ERbButton(
                onTap: () {},
                text: 'Rectangle',
                size: ERbButtonSize.large,
                type: ERbButtonType.fill,
                theme: ERbButtonTheme.primary,
                shape: ERbButtonShape.rectangle,
              ),
              ERbButton(
                onTap: () {},
                text: 'Round',
                size: ERbButtonSize.large,
                type: ERbButtonType.fill,
                theme: ERbButtonTheme.primary,
                shape: ERbButtonShape.round,
              ),
              ERbButton(
                onTap: () {},
                iconLeft: const Icon(
                  Icons.account_balance_rounded,
                  color: Colors.white,
                ),
                size: ERbButtonSize.large,
                type: ERbButtonType.fill,
                theme: ERbButtonTheme.primary,
                shape: ERbButtonShape.square,
              ),
              ERbButton(
                onTap: () {},
                iconLeft: const Icon(
                  Icons.account_balance_rounded,
                  color: Colors.white,
                ),
                size: ERbButtonSize.large,
                type: ERbButtonType.fill,
                theme: ERbButtonTheme.primary,
                shape: ERbButtonShape.circle,
              ),
            ],
          ),
          ERbButton(
            onTap: () {},
            text: 'Filled Button',
            size: ERbButtonSize.large,
            type: ERbButtonType.fill,
            theme: ERbButtonTheme.primary,
            shape: ERbButtonShape.filled,
          ),
        ],
      );

  Widget _buildErbButtonCustomStyle() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ERbButton(
            onTap: () {},
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
        crossAxisAlignment: CrossAxisAlignment.start,
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
