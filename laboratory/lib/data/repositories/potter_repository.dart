import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pmd/data/mapper/house_mapper.dart';
import 'package:pmd/data/dtos/houses_dto.dart';
import 'package:pmd/models/home_data.dart';
import 'package:pmd/data/repositories/api_interface.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class PotterRepository extends ApiInterface {
  static final Dio _dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 10)))
    ..interceptors.add(PrettyDioLogger(request: true, requestHeader: true, requestBody: true));

  static const String _baseUrl = "https://api.potterdb.com/v1"; // https://api.realtor.com/v1

  @override
  Future<HomeData?> loadData(
      {OnErrorCallback? onError, String? q, int page = 1, int pageSize = 10}) async {
    try {
      const String url = '$_baseUrl/characters';

      final Response<dynamic> response = await _dio.get<Map<dynamic, dynamic>>(
        url,
        queryParameters: {'filter[name_cont]': q, 'page[number]': page, 'page[size]': pageSize},
      );

      final HousesDto dto = HousesDto.fromJson(response.data as Map<String, dynamic>);

      return dto.toDomain();
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
