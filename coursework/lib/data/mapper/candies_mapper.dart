import 'package:candystore/data/dtos/candies_dto.dart';
import 'package:candystore/models/card_data.dart';
import 'package:candystore/models/home_data.dart';

extension CandyItemDtoToModel on CandyItemDto {
  CardData toDomain() => CardData(
      name: name ?? "UNKNOWN",
      imageUrl: imageUrl ??
          "https://upload.wikimedia.org/wikipedia/commons/a/a2/Person_Image_Placeholder.png",
      description: description ?? "UNKNOWN",
      manufacturer: manufacturer ?? ["UNKNOWN"],
      id: id);
}

extension CandiesDtoToModel on CandiesResponseDto {
  HomeData toDomain() => HomeData(
        data: items?.map((e) => e.toDomain()).toList(),
        nextPage: currentPage != null && totalPages != null && currentPage! < totalPages!
            ? currentPage! + 1
            : null,
        currentPage: currentPage,
        totalPages: totalPages,
      );
}
