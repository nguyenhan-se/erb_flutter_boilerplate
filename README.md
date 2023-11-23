# riverpod_rnd

A new Flutter project.

## Getting Started

### Requirements

- Dart: 3.1.0
- Flutter SDK: 3.13.0

# Building from Source

- Sync dependencies

```bash
flutter pub get
```

- Run code generator

```bash
dart run build_runner build --delete-conflicting-outputs
```

- Generate translation

```bash
dart run slang
```

- Run the app with your favorite IDE/PDE. or from shell:

```bash
flutter run
```

## Libraries

### Melos

This project uses [Melos](https://pub.dev/packages/melos) to manage the monorepo.

  ```bash
  flutter pub get
  # Install melos globally
  dart pub global activate melos
  # Setup local dependency overrides for packages in the monorepo
  melos bootstrap

  # Or if dart executables are not on your path
  dart pub global run melos bootstrap
  ```
  
#### Scripts

Pub:

- `melos run pub` - Run `pub get` in all packages.
- `melos run dart:pkg` - Run `dart pub get` in the selected dart package.
- `melos run flutter:pkg` - Run `flutter pub get` in the selected flutter package.
- `melos run upgrade` - Run `pub upgrade` in all packages.
- `melos run upgrade:pkg` - Run `pub upgrade` in the selected package.

Code Generation:

- `dart run build_runner watch -d` - Watch and generate code for the app, does not work with subpackages
- `melos run generate` - Run `build_runner build` in all packages that depend on `build_runner`.
- `melos run generate:pkg` - Run `build_runner build` for a specific package (except `envied` packages).
- `melos run watch:pkg` - Run `build_runner watch` for a specific package (except `envied` packages). It will not work if you choose "all" in the package selection prompt.
- `melos run assets` - Run `assets_gen build` in all packages that depend on `assets_gen`.
- `melos run assets:pkg` - Run `assets_gen build` for a specific package.
- `melos run env` - Run `build_runner` in all packages that depends on `envied`.
- `melos run env:pkg` - Run `build_runner` in a specific package that depends on `envied`.
- `melos run loc` - Run `flutter gen-l10n` in the localization package to generate
  the localized strings from the arb files.

### Protip

- Run [build_runner](https://pub.dev/packages/build_runner) after editing some areas that needs a code generator such as entities and routing.
- Run [slang](https://pub.dev/packages/slang) after editing translation files (\*.i18n.json).
- [build_runner](https://pub.dev/packages/build_runner) and [slang](https://pub.dev/packages/slang) has some features that will be helpful during development such as auto-rebuild and translation analysis, so it's highly recommended to check the documentations and familiarize yourself with it.

# Translation

### Translating untranslated strings

- Run slang analyzer to check for missing translations

```bash
dart run slang analyze --outdir=i18n
```

- Open [i18n/\_missing_translations.json](i18n/_missing_translations.json) and then translate your language of choice.

- After editing the file, you can apply it to the actual json translation file by running:

```bash
dart run slang apply --outdir=i18n

dart run slang analyze --outdir=i18n # update analyzation result files
