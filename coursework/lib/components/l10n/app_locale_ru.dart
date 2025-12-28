import 'app_locale.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocaleRu extends AppLocale {
  AppLocaleRu([String locale = 'ru']) : super(locale);

  @override
  String get cardLiked => 'Конфета добавлена в понравившиеся :)';

  @override
  String get cardDisliked => 'Конфета удалена из понравившегося :(';

  @override
  String get searchInputPlaceholder => 'Поиск ..';

  @override
  String get titleCard => 'Название';

  @override
  String get descriptionCard => 'Описание';

  @override
  String get manufacturer => 'Производитель';

  @override
  String get price => 'Цена';
}
