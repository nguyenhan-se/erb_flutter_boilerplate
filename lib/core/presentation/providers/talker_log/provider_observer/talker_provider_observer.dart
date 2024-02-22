import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'provider_ext.dart';
import 'talker_provider_logs.dart';
import 'talker_provider_observer_setting.dart';

class TalkerProviderObserver extends ProviderObserver {
  TalkerProviderObserver({
    Talker? talker,
    this.settings = const TalkerProviderObserverSettings(),
  }) {
    _talker = talker ?? Talker();
  }

  late Talker _talker;
  final TalkerProviderObserverSettings settings;

  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    super.didAddProvider(provider, value, container);
    if (value is AsyncError) return;

    if (!settings.enabled || !settings.printDidAddProvider) {
      return;
    }

    _talker.logTyped(
      ProviderAddLog(
        provider: provider,
        container: container,
        value: value,
        settings: settings,
      ),
    );
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    super.didDisposeProvider(provider, container);

    if (!settings.enabled || !settings.printDidDisposeProvider) {
      return;
    }

    _talker.warning('🗑️ DidDisposeProvider: ${provider.providerName}');
  }

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    super.didUpdateProvider(provider, previousValue, newValue, container);
    if (newValue is AsyncError) return;

    if (!settings.enabled || !settings.printDidUpdateProvider) {
      return;
    }

    _talker.logTyped(
      ProviderUpdateLog(
        provider: provider,
        container: container,
        settings: settings,
        previousValue: previousValue,
        newValue: newValue,
      ),
    );
  }

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    super.providerDidFail(provider, error, stackTrace, container);
    if (!settings.enabled || !settings.printDidFail) {
      return;
    }
    _talker.error('ProviderDidFail: ${provider.name}', error, stackTrace);
  }
}
