// TranslationBuilder useI18n(
//   WidgetRef ref,
// ) {
//   final context = useContext();

//   // const context = useContext();

//   // final currentTranslate = useState(Translations.of(context));

//   // // final state = useState(null);
//   // final currentLocale =
//   //     useMemoized(() => ref.watch(currentLanguageProvider) ?? AppLocale.vi);

//   // useEffect(() {
//   //   currentTranslate.value = AppLocaleUtils.parseLocaleParts(
//   //           languageCode: currentLocale.languageCode,
//   //           countryCode: currentLocale.countryCode)
//   //       .build() as Null;

//   //   return;
//   // }, [currentLocale]);

//   // return TranslationProvider.of(context).translations;
//   // return (String key, [Map<String, String> params = const {}]) {
//   //   return TranslationProvider.of(this).translations;
//   // };
//   return (String key, [Map<String, String> params = const {}]) {
//     return AppLocale.vi.build();
//   };
// }

typedef Translate = String Function(String, [Map<String, String>]);
