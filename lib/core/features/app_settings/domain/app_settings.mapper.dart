// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'app_settings.dart';

class AppSettingsMapper extends ClassMapperBase<AppSettings> {
  AppSettingsMapper._();

  static AppSettingsMapper? _instance;
  static AppSettingsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AppSettingsMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AppSettings';

  static bool _$bannerEnabled(AppSettings v) => v.bannerEnabled;
  static const Field<AppSettings, bool> _f$bannerEnabled =
      Field('bannerEnabled', _$bannerEnabled, opt: true, def: true);
  static bool _$darkMode(AppSettings v) => v.darkMode;
  static const Field<AppSettings, bool> _f$darkMode =
      Field('darkMode', _$darkMode, opt: true, def: false);
  static bool _$systemThemeMode(AppSettings v) => v.systemThemeMode;
  static const Field<AppSettings, bool> _f$systemThemeMode =
      Field('systemThemeMode', _$systemThemeMode, opt: true, def: true);

  @override
  final Map<Symbol, Field<AppSettings, dynamic>> fields = const {
    #bannerEnabled: _f$bannerEnabled,
    #darkMode: _f$darkMode,
    #systemThemeMode: _f$systemThemeMode,
  };

  static AppSettings _instantiate(DecodingData data) {
    return AppSettings(
        bannerEnabled: data.dec(_f$bannerEnabled),
        darkMode: data.dec(_f$darkMode),
        systemThemeMode: data.dec(_f$systemThemeMode));
  }

  @override
  final Function instantiate = _instantiate;

  static AppSettings fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AppSettings>(map);
  }

  static AppSettings fromJson(String json) {
    return ensureInitialized().decodeJson<AppSettings>(json);
  }
}

mixin AppSettingsMappable {
  String toJson() {
    return AppSettingsMapper.ensureInitialized()
        .encodeJson<AppSettings>(this as AppSettings);
  }

  Map<String, dynamic> toMap() {
    return AppSettingsMapper.ensureInitialized()
        .encodeMap<AppSettings>(this as AppSettings);
  }

  AppSettingsCopyWith<AppSettings, AppSettings, AppSettings> get copyWith =>
      _AppSettingsCopyWithImpl(this as AppSettings, $identity, $identity);
  @override
  String toString() {
    return AppSettingsMapper.ensureInitialized()
        .stringifyValue(this as AppSettings);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            AppSettingsMapper.ensureInitialized()
                .isValueEqual(this as AppSettings, other));
  }

  @override
  int get hashCode {
    return AppSettingsMapper.ensureInitialized().hashValue(this as AppSettings);
  }
}

extension AppSettingsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AppSettings, $Out> {
  AppSettingsCopyWith<$R, AppSettings, $Out> get $asAppSettings =>
      $base.as((v, t, t2) => _AppSettingsCopyWithImpl(v, t, t2));
}

abstract class AppSettingsCopyWith<$R, $In extends AppSettings, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({bool? bannerEnabled, bool? darkMode, bool? systemThemeMode});
  AppSettingsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AppSettingsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AppSettings, $Out>
    implements AppSettingsCopyWith<$R, AppSettings, $Out> {
  _AppSettingsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AppSettings> $mapper =
      AppSettingsMapper.ensureInitialized();
  @override
  $R call({bool? bannerEnabled, bool? darkMode, bool? systemThemeMode}) =>
      $apply(FieldCopyWithData({
        if (bannerEnabled != null) #bannerEnabled: bannerEnabled,
        if (darkMode != null) #darkMode: darkMode,
        if (systemThemeMode != null) #systemThemeMode: systemThemeMode
      }));
  @override
  AppSettings $make(CopyWithData data) => AppSettings(
      bannerEnabled: data.get(#bannerEnabled, or: $value.bannerEnabled),
      darkMode: data.get(#darkMode, or: $value.darkMode),
      systemThemeMode: data.get(#systemThemeMode, or: $value.systemThemeMode));

  @override
  AppSettingsCopyWith<$R2, AppSettings, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AppSettingsCopyWithImpl($value, $cast, t);
}
