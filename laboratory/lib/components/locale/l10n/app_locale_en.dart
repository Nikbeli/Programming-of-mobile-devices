import 'app_locale.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocaleEn extends AppLocale {
  AppLocaleEn([String locale = 'en']) : super(locale);

  @override
  String get cardLiked => 'Card added to your favorite :)';

  @override
  String get cardDisliked => 'Card deleted from favourite :(';

  @override
  String get searchInputPlaceholder => 'Search ..';

  @override
  String get detailsTitle => 'Title:';

  @override
  String get detailsLocation => 'Location';

  @override
  String get detailsDescription => 'Description';
}
