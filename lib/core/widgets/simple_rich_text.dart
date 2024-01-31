import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

//       ------------------Example---------------
//  SimpleRichText(
//                 text:
//                     'Text in *bold* , Text in !blue!, Text custom patter @comment ',
//                 style: const TextStyle(fontSize: 16, color: Colors.black),
//                 othersMarkers: [
//                   OthersMarker(
//                     marker: '*',
//                     style: const TextStyle(
//                       fontSize: 20,
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   OthersMarker(
//                     marker: '!',
//                     style: const TextStyle(
//                       fontSize: 20,
//                       color: Colors.blue,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   OthersMarker(
//                     marker: '@',
//                     patternMarker: (m) => "\\$m.*?\\ ",
//                     style: const TextStyle(
//                       fontSize: 20,
//                       color: Colors.blue,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               )

typedef RemoveMarker = String Function(
    String text, RegExpMatch match, String marker);

class OthersMarker {
  final String marker;
  final Function(String marker)? patternMarker;
  final RemoveMarker? removeMarker;
  final TextStyle? style;
  final GestureRecognizer? recognizer;
  final MouseCursor? mouseCursor;
  final void Function(PointerEnterEvent)? onEnter;
  final void Function(PointerExitEvent)? onExit;
  final String? semanticsLabel;
  final Locale? locale;
  final bool? spellOut;

  OthersMarker({
    required this.marker,
    this.patternMarker,
    this.removeMarker,
    this.style,
    this.recognizer,
    this.mouseCursor,
    this.onEnter,
    this.onExit,
    this.semanticsLabel,
    this.locale,
    this.spellOut,
  });
}

class SimpleRichText extends StatelessWidget {
  const SimpleRichText({
    super.key,
    required this.text,
    this.style,
    this.othersMarkers,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.softWrap = true,
    this.overflow = TextOverflow.clip,
    this.textScaler = TextScaler.noScaling,
    this.maxLines,
    this.locale,
    this.strutStyle,
    this.textWidthBasis = TextWidthBasis.parent,
    this.textHeightBehavior,
    this.selectionRegistrar,
    this.selectionColor,
  });

  final String text;
  final TextStyle? style;
  final List<OthersMarker>? othersMarkers;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final bool softWrap;
  final TextOverflow overflow;
  final TextScaler textScaler;
  final int? maxLines;
  final Locale? locale;
  final StrutStyle? strutStyle;
  final TextWidthBasis textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final SelectionRegistrar? selectionRegistrar;
  final Color? selectionColor;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: _inlineSpans,
      ),
      textAlign: textAlign,
      textDirection: textDirection,
      softWrap: softWrap,
      overflow: overflow,
      textScaler: textScaler,
      maxLines: maxLines,
      locale: locale,
      strutStyle: strutStyle,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionRegistrar: selectionRegistrar,
      selectionColor: selectionColor,
    );
  }

  List<_FoundMarker> _foundMarker() {
    List<_FoundMarker> foundOverrideStyle = [];
    for (var othersMarker in othersMarkers ?? <OthersMarker>[]) {
      final String m = othersMarker.marker;
      final String pattern =
          othersMarker.patternMarker?.call(m) ?? "\\$m.*?\\$m";

      final found = RegExp(pattern).allMatches(text).toList();

      foundOverrideStyle.addAll(
        found.map(
          (match) => _FoundMarker(
            regMatch: match,
            customMarker: othersMarker,
            pattern: pattern,
          ),
        ),
      );
    }

    foundOverrideStyle.sort(
      (a, b) => a.regMatch.start.compareTo(b.regMatch.start),
    );

    return foundOverrideStyle;
  }

  List<InlineSpan> get _inlineSpans {
    List<InlineSpan> spans = [];
    final foundMarkets = _foundMarker();

    int endCodeStyle = 0;

    for (var marker in foundMarkets) {
      final regMatch = marker.regMatch;
      final customMarker = marker.customMarker;

      if (endCodeStyle < regMatch.end) {
        spans.add(
          TextSpan(
            text: text.substring(endCodeStyle, regMatch.start),
            style: style,
          ),
        );
      }

      spans.add(
        TextSpan(
          text: customMarker.removeMarker
                  ?.call(text, regMatch, customMarker.marker) ??
              text.substring(
                regMatch.start + 1,
                regMatch.end - 1,
              ), //remove markup
          style: customMarker.style,
          recognizer: customMarker.recognizer,
          mouseCursor: customMarker.mouseCursor,
          onEnter: customMarker.onEnter,
          onExit: customMarker.onExit,
          semanticsLabel: customMarker.semanticsLabel,
          locale: customMarker.locale,
          spellOut: customMarker.spellOut,
        ),
      );

      endCodeStyle = regMatch.end;
    }

    spans.add(
      TextSpan(
        text: text.substring(endCodeStyle, text.length),
        style: style,
      ),
    );

    return spans;
  }
}

class _FoundMarker {
  final RegExpMatch regMatch;
  final OthersMarker customMarker;
  final String pattern;

  _FoundMarker({
    required this.regMatch,
    required this.customMarker,
    required this.pattern,
  });
}
