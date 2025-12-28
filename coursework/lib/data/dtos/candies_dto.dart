import 'package:json_annotation/json_annotation.dart';

part 'candies_dto.g.dart';

@JsonSerializable(createToJson: false)
class CandiesResponseDto {
  // Для пагинации
  final int? totalCount;
  final int? pageSize;
  final int? currentPage;
  final int? totalPages;

  // Сами данные сущности
  final List<CandyItemDto>? items;

  const CandiesResponseDto(
      {this.totalCount, this.pageSize, this.currentPage, this.totalPages, this.items});

  factory CandiesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CandiesResponseDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class CandyItemDto {
  @JsonKey(name: "beanId")
  final int? id;

  @JsonKey(name: "flavorName")
  final String? name;
  final String? description;
  final String? imageUrl;

  @JsonKey(name: "groupName")
  final List<String>? manufacturer;

  const CandyItemDto(
      {this.id,
      this.name,
      this.description,
      this.imageUrl,
      this.manufacturer});

  factory CandyItemDto.fromJson(Map<String, dynamic> json) => _$CandyItemDtoFromJson(json);
}

extension CandiesResponseDtoExtensions on CandiesResponseDto {
  CandiesResponseDto copyWithFilteredItems(List<CandyItemDto>? items) {
    return CandiesResponseDto(
      totalCount: items?.length,
      pageSize: pageSize,
      currentPage: currentPage,
      totalPages: totalPages,
      items: items,
    );
  }
}

