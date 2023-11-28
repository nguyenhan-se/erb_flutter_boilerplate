import 'package:hooks_riverpod/hooks_riverpod.dart';

extension ProviderBaseX on ProviderBase<dynamic> {
  String get providerName => (name ?? runtimeType).toString();
}
