import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'talker_provider_observer_setting.dart';
import 'provider_ext.dart';

class ProviderAddLog extends TalkerLog {
  ProviderAddLog({
    required this.provider,
    required this.value,
    required this.container,
    required this.settings,
  }) : super('➕ DidAddProvider: ${provider.providerName}\n'
            '=> value: $value\n');

  final ProviderBase<Object?> provider;
  final Object? value;
  final ProviderContainer container;
  final TalkerProviderObserverSettings settings;

  @override
  AnsiPen get pen => AnsiPen()..xterm(51);

  @override
  String get title => talkerTitle;

  @override
  String generateTextMessage(
      {TimeFormat timeFormat = TimeFormat.timeAndSeconds}) {
    return _createMessage();
  }

  String _createMessage() {
    final sb = StringBuffer();
    sb.write(displayTitleWithTime);
    sb.write('\n***DidAddProvider***');
    sb.write('\n$message');
    return sb.toString();
  }
}

class ProviderUpdateLog extends TalkerLog {
  ProviderUpdateLog({
    required this.provider,
    required this.container,
    required this.settings,
    super.logLevel,
    this.previousValue,
    this.newValue,
  }) : super('🔄 DidUpdateProvider: ${provider.name}');

  final ProviderBase<Object?> provider;
  final Object? previousValue;
  final Object? newValue;
  final ProviderContainer container;
  final TalkerProviderObserverSettings settings;

  @override
  AnsiPen get pen => AnsiPen()..xterm(49);

  @override
  String get title => talkerTitle;

  @override
  String generateTextMessage(
      {TimeFormat timeFormat = TimeFormat.timeAndSeconds}) {
    return _createMessage();
  }

  String _createMessage() {
    final sb = StringBuffer();
    sb.write(displayTitleWithTime);
    sb.write('\n***DidUpdateProvider***');
    sb.write('\n$message');
    sb.write('\n${'CURRENT: $previousValue'}');
    sb.write('\n${'NEXT: $newValue'}');
    return sb.toString();
  }
}
