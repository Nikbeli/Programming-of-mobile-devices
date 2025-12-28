// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'houses_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HousesDto _$HousesDtoFromJson(Map<String, dynamic> json) => HousesDto(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => HouseDataDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null ? null : MetaDto.fromJson(json['meta'] as Map<String, dynamic>),
    );

MetaDto _$MetaDtoFromJson(Map<String, dynamic> json) => MetaDto(
      pagination: json['pagination'] == null
          ? null
          : PaginationDto.fromJson(json['pagination'] as Map<String, dynamic>),
    );

PaginationDto _$PaginationDtoFromJson(Map<String, dynamic> json) => PaginationDto(
      current: (json['current'] as num?)?.toInt(),
      last: (json['last'] as num?)?.toInt(),
      next: (json['next'] as num?)?.toInt(),
    );

HouseDataDto _$HouseDataDtoFromJson(Map<String, dynamic> json) => HouseDataDto(
      json['id'] as String?,
      json['attributes'] == null
          ? null
          : HouseAttributesDataDto.fromJson(json['attributes'] as Map<String, dynamic>),
    );

HouseAttributesDataDto _$HouseAttributesDataDtoFromJson(Map<String, dynamic> json) =>
    HouseAttributesDataDto(
      json['name'] as String?,
      json['location'] as String?,
      json['image'] as String?,
      json['description'] as String?,
    );
