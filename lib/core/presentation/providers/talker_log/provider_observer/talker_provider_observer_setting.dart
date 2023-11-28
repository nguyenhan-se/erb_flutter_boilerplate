class TalkerProviderObserverSettings {
  const TalkerProviderObserverSettings({
    this.enabled = true,
    this.printDidAddProvider = true,
    this.printDidDisposeProvider = true,
    this.printDidUpdateProvider = false,
    this.printDidFail = true,
  });

  final bool enabled;
  final bool printDidAddProvider;
  final bool printDidDisposeProvider;
  final bool printDidUpdateProvider;
  final bool printDidFail;
}

const talkerTitle = 'Riverpod';
