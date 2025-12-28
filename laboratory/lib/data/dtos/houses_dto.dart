import 'package:json_annotation/json_annotation.dart';

// dart run build_runner build --delete-conflicting-outputs
// flutter pub run build_runner build --delete-conflicting-outputs

part 'houses_dto.g.dart';

@JsonSerializable(createToJson: false)
class HousesDto {
  final List<HouseDataDto>? data;
  final MetaDto? meta;

  const HousesDto({this.data, this.meta});

  factory HousesDto.fromJson(Map<String, dynamic> json) => _$HousesDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class MetaDto {
  final PaginationDto? pagination;

  const MetaDto({this.pagination});

  factory MetaDto.fromJson(Map<String, dynamic> json) => _$MetaDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class PaginationDto {
  final int? current;
  final int? next;
  final int? last;

  const PaginationDto({this.current, this.last, this.next});

  factory PaginationDto.fromJson(Map<String, dynamic> json) => _$PaginationDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class HouseDataDto {
  final String? id;
  final HouseAttributesDataDto? attributes;

  const HouseDataDto(this.id, this.attributes);

  factory HouseDataDto.fromJson(Map<String, dynamic> json) => _$HouseDataDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class HouseAttributesDataDto {
  final String? name;
  final String? location;
  final String? image;
  final String? description;

  HouseAttributesDataDto(this.name, this.location, this.image, this.description);

  factory HouseAttributesDataDto.fromJson(Map<String, dynamic> json) =>
      _$HouseAttributesDataDtoFromJson(json);
}
