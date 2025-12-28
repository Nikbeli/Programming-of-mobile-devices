part of "home_page.dart";

typedef OnLikeCallback = void Function(int? id, String text, bool isLiked);

class Card extends StatefulWidget {
  final int? id;
  final String name;
  final String description;
  final String image;
  final bool isLiked;
  final OnLikeCallback? onLike;
  final VoidCallback? onTap;

  const Card({
    super.key,
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.onLike,
    required this.onTap,
    this.isLiked = false,
  });

  factory Card.fromData(CardData data,
      {OnLikeCallback? onLike,
        VoidCallback? onTap,
        bool isLiked = false}) =>
      Card(
        id: data.id,
        name: data.name,
        description: data.description,
        image: data.imageUrl,
        isLiked: isLiked,
        onLike: onLike,
        onTap: onTap,
      );

  @override
  CardState createState() => CardState();
}

class CardState extends State<Card> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // Дрожание: последовательность колебаний с разными масштабами
    _shakeAnimation = TweenSequence<double>([
      TweenSequenceItem<double>(
        tween: Tween(begin: 1.0, end: 1.1).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 50,
      ),
      TweenSequenceItem<double>(
        tween: Tween(begin: 1.1, end: 0.9).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 50,
      ),
      TweenSequenceItem<double>(
        tween: Tween(begin: 0.9, end: 1.0).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 50,
      ),
    ]).animate(_animationController);
  }

  void toggleIsFavourite() {
    widget.onLike?.call(
      widget.id,
      !widget.isLiked ? context.locale.cardLiked : context.locale.cardDisliked,
      widget.isLiked,
    );
    // Запуск анимации при изменении состояния лайка
    _animationController.forward(from: 0.0); // Перезапуск анимации с начала
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 15, bottom: 15, left: 30, right: 30),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 2),
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: toggleIsFavourite, // Переключение состояния лайка
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _shakeAnimation.value, // Используем анимацию для дрожания
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: widget.isLiked
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
                      );
                    },
                  ),
                )
              ],
            ),
            const SizedBox(height: 20, width: 150),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 270, // Максимальная ширина изображения
                ),
                child: AspectRatio(
                  aspectRatio: 6 / 4, // Соотношение сторон (4:3)
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(
                      widget.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                        fontSize: 28,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SanFrancisco'),
                  ),
                  Text(
                    "${context.locale.price}: ${(((widget.id ?? 1) % 10 + 1) * (pi * 0.2 + 0.1)).toStringAsFixed(2)} \$",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'SanFrancisco'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
