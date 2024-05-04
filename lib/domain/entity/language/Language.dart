class Language {
  /// the country code (IT,AF..)
  String code;

  /// the locale (en, es, da)
  String locale;

  /// the full name of language (English, Danish..)
  String language;

  /// map of keys used based on industry type (service worker, route etc)
  Map<String, String>? dictionary;

  Language({
    required this.code,
    required this.locale,
    required this.language,
    this.dictionary,
  });

  factory Language.fromMap(Map<String, dynamic> map) {
    return Language(
      code: map['code'],
      locale: map['locale'],
      language: map['language'],
      dictionary: map['dictionary'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'locale': locale,
      'language': language,
      'dictionary': dictionary,
    };
  }
}
