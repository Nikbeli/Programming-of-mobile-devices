// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'candies_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CandiesResponseDto _$CandiesResponseDtoFromJson(Map<String, dynamic> json) =>
    CandiesResponseDto(
      totalCount: (json['totalCount'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
      currentPage: (json['currentPage'] as num?)?.toInt(),
      totalPages: (json['totalPages'] as num?)?.toInt(),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => CandyItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

CandyItemDto _$CandyItemDtoFromJson(Map<String, dynamic> json) => CandyItemDto(
      id: (json['beanId'] as num?)?.toInt(),
      name: json['flavorName'] as String?,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      manufacturer: (json['groupName'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
