import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

const _defaultAnimationDuration = Duration(milliseconds: 200);

//NOTE: Do not use with ERbFillViewportScrollView
//Use only when height has been determined
class ExpandableText extends HookWidget {
  const ExpandableText({
    required this.text,
    this.expandText = ' ...',
    this.expanded = false,
    this.style,
    this.onExpand,
    this.isTriggerAllText = true,
    this.collapseText,
    this.expandedStyle,
    this.collapseStyle,
    this.textDirection,
    this.textAlign,
    this.textScaleFactor,
    this.maxLines = 4,
    this.expandedDuration,
    this.animationCurve,
    this.semanticsLabel,
    super.key,
  });

  final String text;
  final String expandText;
  final bool expanded;
  final Function(bool)? onExpand;
  final bool isTriggerAllText;
  final String? collapseText;
  final TextStyle? style;
  final TextStyle? expandedStyle;
  final TextStyle? collapseStyle;
  final TextDirection? textDirection;
  final TextAlign? textAlign;
  final double? textScaleFactor;
  final int maxLines;
  final Duration? expandedDuration;
  final Curve? animationCurve;
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(expanded);

    useEffect(() {
      isExpanded.value = expanded;
      return;
    }, [expanded]);

    Future<void> updateExpanded() async {
      await onExpand?.call(!isExpanded.value);
      isExpanded.value = !isExpanded.value;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;

        TextSpan richText = TextSpan(
          text: text,
          style: style,
          children: [
            if (isExpanded.value)
              TextSpan(
                text: collapseText,
                style: collapseStyle ?? style,
                recognizer: TapGestureRecognizer()..onTap = updateExpanded,
              )
          ],
        );

        if (!isExpanded.value) {
          TextPainter textPainter = TextPainter(
            textDirection: textDirection ?? TextDirection.ltr,
            maxLines: maxLines,
            textAlign: textAlign ?? TextAlign.start,
            text: TextSpan(
              style: expandedStyle ?? style,
              text: expandText,
            ),
          );
          //get size text expanded
          textPainter.layout(
              minWidth: constraints.minWidth, maxWidth: maxWidth);

          final expandedSize = textPainter.size;

          //get size text content
          textPainter.text = TextSpan(text: text, style: style);
          textPainter.layout(
              minWidth: constraints.minWidth, maxWidth: maxWidth);

          final textSize = textPainter.size;

          if (textPainter.didExceedMaxLines) {
            final position = textPainter.getPositionForOffset(Offset(
              textSize.width - expandedSize.width,
              textSize.height,
            ));
            final endOffset =
                (textPainter.getOffsetBefore(position.offset) ?? 0);

            richText = TextSpan(
              text: text.substring(
                0,
                max(endOffset, 0),
              ),
              style: style,
              children: [
                TextSpan(
                  text: expandText,
                  style: expandedStyle ?? style,
                  recognizer: TapGestureRecognizer()..onTap = updateExpanded,
                )
              ],
            );
          }
        }

        return GestureDetector(
          onTap: isTriggerAllText ? updateExpanded : null,
          child: AnimatedSize(
            duration: expandedDuration ?? _defaultAnimationDuration,
            curve: animationCurve ?? Curves.fastLinearToSlowEaseIn,
            alignment: Alignment.topLeft,
            child: RichText(
              maxLines: isExpanded.value ? null : maxLines,
              overflow: TextOverflow.clip,
              softWrap: true,
              text: richText,
              textAlign: textAlign ?? TextAlign.start,
              textDirection: textDirection,
            ),
          ),
        );
      },
    );
  }
}
