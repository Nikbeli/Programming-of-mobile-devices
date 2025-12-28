import 'app_locale.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocaleEn extends AppLocale {
  AppLocaleEn([String locale = 'en']) : super(locale);

  @override
  String get cardLiked => 'Candy added to your favorite :)';

  @override
  String get cardDisliked => 'Candy deleted form favorite :(';

  @override
  String get searchInputPlaceholder => 'Search ..';

  @override
  String get titleCard => 'Title';

  @override
  String get descriptionCard => 'Description';

  @override
  String get manufacturer => 'Manufacturer';

  @override
  String get price => 'Price';
}
