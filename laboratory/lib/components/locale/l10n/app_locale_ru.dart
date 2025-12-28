import 'app_locale.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocaleRu extends AppLocale {
  AppLocaleRu([String locale = 'ru']) : super(locale);

  @override
  String get cardLiked => 'Добавлено в понравившиеся :)';

  @override
  String get cardDisliked => 'Удалено из понравившегося :(';

  @override
  String get searchInputPlaceholder => 'Поиск ..';

  @override
  String get detailsTitle => 'Название:';

  @override
  String get detailsLocation => 'Местоположение';

  @override
  String get detailsDescription => 'Описание';
}
