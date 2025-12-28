import '../dtos/houses_dto.dart';
import 'package:pmd/models/home_data.dart';
import 'package:pmd/models/card_data.dart';

extension HouseDataDtoToModel on HouseDataDto {
  CardData toDomain() => CardData(
      id: id,
      name: attributes?.name ?? "UNKNOWN",
      location: attributes?.location ?? "UNKNOWN", // Безопасный доступ к location
      image: attributes?.image ??
          "https://upload.wikimedia.org/wikipedia/commons/a/a2/Person_Image_Placeholder.png",
      description: attributes?.description ?? "UNKNOWN");
}

extension HousesDtoToModel on HousesDto {
  HomeData toDomain() =>
      HomeData(data: data?.map((e) => e.toDomain()).toList(), nextPage: meta?.pagination?.next);
}
