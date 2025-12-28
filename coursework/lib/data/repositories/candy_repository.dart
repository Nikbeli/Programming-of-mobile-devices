import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'package:candystore/data/dtos/candies_dto.dart';
import 'package:candystore/data/mapper/candies_mapper.dart';
import 'package:candystore/data/repositories/api_interface.dart';
import 'package:candystore/models/home_data.dart';

class CandyRepository extends ApiInterface {
  static final Dio _dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 10)))
    ..interceptors.add(PrettyDioLogger(request: true, requestHeader: true, requestBody: true));

  static const String _baseUrl = "https://jellybellywikiapi.onrender.com/api";

  @override
  Future<HomeData?> loadData(
      {OnErrorCallback? onError, String? q, int page = 1, int pageSize = 10}) async {
    try {
      const String url = '$_baseUrl/Beans?';

      final Response<dynamic> response = await _dio.get<Map<dynamic, dynamic>>(
        url,
        queryParameters: {
          'pageIndex': page,
          'pageSize': pageSize},
      );

      final CandiesResponseDto dto =
          CandiesResponseDto.fromJson(response.data as Map<String, dynamic>);

      // Если `q` указан, фильтруем данные
      List<CandyItemDto>? filteredItems;
      if (q != null && q.isNotEmpty) {
        final query = q.toLowerCase();
        filteredItems = dto.items?.where((item) {
          final flavorName = item.name?.toLowerCase() ?? '';
          return flavorName.contains(query); // Динамическое совпадение
        }).toList();
      }

      // Создаём новый объект с отфильтрованными элементами (или возвращаем полный список)
      final filteredDto = dto.copyWithFilteredItems(filteredItems ?? dto.items);

      return filteredDto.toDomain();
    } on DioException catch (e) {
      log("DioException: $e");
      onError?.call(e.error?.toString());
      return null;
    } catch (e) {
      log('Unknown error: $e');
      return null;
    }
  }
}
