class CardData {
  final String name;
  final String location;
  final String image;
  final String description;
  final String? id;

  const CardData(
      {required this.id,
      required this.name,
      required this.location,
      required this.image,
      required this.description});
}
