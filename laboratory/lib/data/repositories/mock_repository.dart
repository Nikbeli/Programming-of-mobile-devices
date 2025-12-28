import 'package:pmd/models/card_data.dart';
import 'package:pmd/data/repositories/api_interface.dart';
import 'package:pmd/models/home_data.dart';

class MockRepository extends ApiInterface {
  // Список всех данных
  final List<CardData> allData = [
    const CardData(
        id: "0",
        name: "house 0",
        image: "https://cdn0.youla.io/files/images/780_780/63/29/6329d9f543eedb62b7695786-1.jpg",
        location: "Moscow",
        description: "description null"),
    const CardData(
        id: "1",
        name: "house 1",
        image: "https://cdn0.youla.io/files/images/780_780/63/29/6329d9f543eedb62b7695786-1.jpg",
        location: "Samara",
        description: "null"),
    const CardData(
        id: "2",
        name: "house 2",
        image: "https://cdn0.youla.io/files/images/780_780/63/29/6329d9f543eedb62b7695786-1.jpg",
        location: "Moscow",
        description: "house good, very good"),
    const CardData(
        id: "3",
        name: "house 3",
        image: "https://cdn0.youla.io/files/images/780_780/63/29/6329d9f543eedb62b7695786-1.jpg",
        location: "Kazan",
        description: "house good"),
    const CardData(
        id: "4",
        name: "house 4",
        image: "https://cdn0.youla.io/files/images/780_780/63/29/6329d9f543eedb62b7695786-1.jpg",
        location: "Moscow",
        description: "Moscow city")
  ];

  @override
  Future<HomeData?> loadData({
    String? q, // Поисковый запрос
    int page = 1, // Страница по умолчанию
    int pageSize = 2, // Количество элементов на странице
    List<CardData>? currentData, // Текущие данные для динамического обновления
    OnErrorCallback? onError,
  }) async {
    try {
      // Симуляция задержки сети для динамического обновления
      await Future.delayed(const Duration(seconds: 1));

      // Фильтрация данных по запросу, если он задан
      List<CardData> filteredData = allData
          .where((card) => q == null || card.name.toLowerCase().contains(q.toLowerCase()))
          .toList();

      // Определяем начало и конец диапазона для пагинации
      final int startIndex = (page - 1) * pageSize;
      final int endIndex = startIndex + pageSize;

      // Убедитесь, что индекс не выходит за пределы списка
      if (startIndex >= filteredData.length) {
        return HomeData(
            data: currentData ?? []); // Возвращаем текущие данные, если больше нет данных
      }

      // Извлекаем нужную страницу данных
      List<CardData> paginatedData = filteredData.sublist(
        startIndex,
        endIndex > filteredData.length ? filteredData.length : endIndex,
      );

      // Добавляем новые данные к текущим
      if (currentData != null) {
        paginatedData = [...currentData, ...paginatedData];
      }

      return HomeData(data: paginatedData);
    } catch (e) {
      if (onError != null) onError(e.toString());
      return null;
    }
  }
}
