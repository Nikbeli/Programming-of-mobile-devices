class CardData {
  final String name;
  final String imageUrl;
  final String description;
  final List<String> manufacturer;
  final int? id;

  const CardData(
      {required this.name,
      required this.imageUrl,
      required this.description,
      required this.manufacturer,
      required this.id});
}
