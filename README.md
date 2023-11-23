# riverpod_rnd

A new Flutter project.

### Requirements

- Dart: 3.1.0
- Flutter SDK: 3.13.0

## Template: Getting Started

1. Setup:
   1. Install [puro](https://puro.dev) Flutter Environment Manager
   1. Install Flutter using Puro
   1. Install [Melos](https://pub.dev/packages/melos) globally
1. Run `melos bootstrap` to install dependencies for all packages and generate env files.
1. Rename App: [Change App/Package Name](#change-apppackage-name)
1. Update Description: [pubspec.yaml](pubspec.yaml) and [README.md](README.md).
1. Add Environment Variables: [ENVied Environment Variables](#envied-environment-variables) section for details.
1. [Change App Icon: flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons)
1. [Change Splash Screen: flutter_native_splash](https://pub.dev/packages/flutter_native_splash)
1. Setup the release build configuration, see the [Building](#building) section.
1. Setup Codecov for the repository, see the [Codecov documentation](https://docs.codecov.com/docs/quick-start).
1. Setup GitPod for the environment, see the [GitPod documentation](https://www.gitpod.io/docs/quickstart/flutter#flutter-quickstart).
1. (**Important!**) Update the [LICENSE](./LICENSE.md) file. I give permission to relicense any
code provided in this template, but the licenses of the packages must still be followed.
1. Delete this `Template: Getting Started` section from the README.

### Change App/Package Name

1. Run the following command to change the package name, where `com.author.app_name` is the new name for the app.

   ```bash
   flutter pub run change_app_package_name:main com.author.app_name
   ```

1. Search for `erb_flutter_boilerplate` and replace it with your new package identifier
1. Search for `Erb Flutter Boilerplate` and replace it with your new app name
1. Search for `com.example.erb_flutter_boilerplate` and replace it with your new Android bundle identifier
1. Search for `com.example.erb_flutter_boilerplate` and replace it with your new iOS bundle identifier

## Building

This project automatically builds for all platforms without code signing using GitHub Actions.
To build the project locally, follow the instructions in the
[Flutter docs](https://flutter.dev/docs). Only Windows, Android, and iOS build files are currently
uploaded to the CI action fragments.

Instructions for building for release are below:

### Flavors

By default, the app uses the "local" flavor. Run/build the app with `--dart-define FLAVOR=<flavorname>`
to change the flavor. The following flavors are supported:

- `local` - Local development. The text banner changes to "Debug" when in debug mode, "Local" in profile mode, and hidden in release mode.
- `dev` - Development build not intended for release.
- `beta` - Beta build intended for release to testers.
- `staging` - Staging build intended for device integration testing.
- `prod` - Production build intended for release to stores.

## Architecture

This project uses the [Riverpod App Architecture](https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/)
in a feature-first manner where each feature is a separate package in the [lib/src/features/](./lib/src/features/) folder.
Each feature has its own layers, which separate the business logic from the UI.

### Data Layer (Repositories)

The repository pattern consists of Repositories, DTOs, and Data Sources. Their jobs are the following:

1. isolate domain models (or entities) from the implementation details of the data sources in the data layer.
2. convert data transfer objects to validated entities that are understood by the domain layer
3. (optionally) perform operations such as data caching.

Repository pattern use cases:

1. talking to REST APIs
2. talking to local or remote databases (e.g. Sembast, Hive, Firestore, etc.)
3. talking to device-specific APIs (e.g. permissions, camera, location, etc.)

### Domain Layer (Models)

Domain Models, which consist of entity and value objects. It should solve domain-related problems.

The domain models can contain logic for mutating them in an immutable manner, but they should not contain any serialization.

- Note: it is a simple data classes that doesn't have access to repositories, services, or
  other objects that belong outside the domain layer.

### Presentation Layer (Controllers)

- holds business logic
- manage the widget state
- interact with repositories in the data layer

### Application Layer (Service)

Implements application-specific logic by accessing the relevant repositories as needed.
The service classes are not concerned about:

- managing and updating the widget state (that's the job of the controller)
- data parsing and serialization (that's the job of the repositories)

## Libraries

### ENVied Environment Variables

Environment variables are setup using [ENVied](https://pub.dev/packages/envied)
in the [env](packages/env/) package. Environment variables need to be
defined for debug, profile, and release modes.

1. Copy the `*.env.example` files and remove the `.example` extension from them.
1. Add the values for the environment variables in the respective `.env*` file.
   - Each key must be added to each `.env*` file, unless a non null default value is added
     to the `@EnviedField` annotation.
   - It is recommended to use an empty string for the default and use `Env`'s getter to access the value.
1. Update [src/env/app_env_fields.dart](packages/env/lib/src/env/app_env_fields.dart)
with the new environment variables for `AppEnvFieldsGenerated` and `AppEnvFieldsNullable`.
1. Add the new environment variables to the implementing `*Env` classes in the [src/env](packages/env/src/env/) directory.
   - It must be done for *all* even if only one `.env` file is planned to be used
1. Enable `obfuscate` for API keys in the `@EnviedField` annotation. (Note: still assume it is not secure)
1. Optionally, add a `defaultValue` to the `@EnviedField` annotation for keys which are
not required in all modes.

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
```

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
