import 'package:flutter/material.dart';

/// Scrollable layout with fixed content on the bottom.
///
/// This is designed for long screens (usually forms with multiple fields - hence `ERbFormLayout`) with some
/// always-visible, fixed content on the bottom (usually a submit button).
/// The [content] and [bottom] widgets are separated with a semi-transparent fade-bar, so it looks like [bottom] is laid
/// out "above" the [content].
/// When [content] scrolls to the end, fade-bar disappears so that last part of it is fully visible.
class ERbFormLayout extends StatefulWidget {
  final Color? backgroundColor;
  final double fadeBarHeight;
  final Duration fadeDuration;
  final Widget content;
  final Widget bottom;

  ERbFormLayout.simple({
    this.fadeDuration = const Duration(milliseconds: 100),
    required Widget content,
    required this.bottom,
    this.backgroundColor,
    this.fadeBarHeight = 16,
    super.key,
  }) : content = SingleChildScrollView(child: content);

  const ERbFormLayout.raw({
    super.key,
    this.backgroundColor,
    this.fadeBarHeight = 16,
    this.fadeDuration = const Duration(milliseconds: 100),
    required this.content,
    required this.bottom,
  });

  @override
  State<ERbFormLayout> createState() => _ERbFormLayoutState();
}

class _ERbFormLayoutState extends State<ERbFormLayout> {
  bool isFadeBarVisible = true;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor =
        widget.backgroundColor ?? Theme.of(context).scaffoldBackgroundColor;

    return ColoredBox(
      color: backgroundColor,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                _buildContent(),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: _buildFadeBar(backgroundColor)),
              ],
            ),
          ),
          widget.bottom,
        ],
      ),
    );
  }

  Widget _buildFadeBar(Color backgroundColor) {
    return IgnorePointer(
      child: AnimatedOpacity(
        opacity: isFadeBarVisible ? 1 : 0,
        duration: widget.fadeDuration,
        child: Container(
          height: widget.fadeBarHeight,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [backgroundColor.withOpacity(0), backgroundColor],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        final current = notification.metrics.pixels;
        final max = notification.metrics.maxScrollExtent - widget.fadeBarHeight;
        if (!isFadeBarVisible && current < max) {
          setState(() => isFadeBarVisible = true);
        }
        if (isFadeBarVisible && current >= max) {
          setState(() => isFadeBarVisible = false);
        }
        return false;
      },
      child: widget.content,
    );
  }
}
