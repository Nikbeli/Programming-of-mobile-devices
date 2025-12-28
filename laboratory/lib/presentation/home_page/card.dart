part of "home_page.dart";

typedef OnLikeCallback = void Function(String? id, String text, bool isLiked);

class Card extends StatelessWidget {
  final String? id;
  final String name;
  final String location;
  final String image;
  final String description;
  final bool isLiked;

  final OnLikeCallback? onLike;
  final VoidCallback? onTap;

  const Card({
    super.key,
    required this.id,
    required this.name,
    required this.location,
    required this.image,
    required this.description,
    required this.onLike,
    required this.onTap,
    this.isLiked = false,
  });

  factory Card.fromData(CardData data,
          {OnLikeCallback? onLike, VoidCallback? onTap, bool isLiked = false}) =>
      Card(
          id: data.id,
          name: data.name,
          location: data.location,
          image: data.image,
          description: data.description,
          isLiked: isLiked,
          onLike: onLike,
          onTap: onTap);

  @override
  Widget build(BuildContext context) {
    void toggleIsFavourite() {
      onLike?.call(id, !isLiked ? context.locale.cardLiked : context.locale.cardDisliked, isLiked);
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 15, bottom: 15, left: 30, right: 30),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black12, width: 2),
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start, // Выравниваем по левому краю
              children: [
                GestureDetector(
                  onTap: toggleIsFavourite,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: isLiked
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                            key: ValueKey<int>(0),
                          )
                        : const Icon(
                            Icons.favorite_border,
                            color: Colors.red,
                            key: ValueKey<int>(1),
                          ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  // Радиус скругления
                  child: Image.network(image,
                      width: 280, // Ширина изображения
                      height: 350, // Высота изображения
                      fit: BoxFit.cover) // Позволяет изображению подстраиваться под рамки),
                  ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontSize: 17)),
                  Text("Местоположение: ${location}", style: TextStyle(fontSize: 15)),
                  Text("${description}", style: TextStyle(fontSize: 17, color: Colors.orange))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
