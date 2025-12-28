import 'package:candystore/presentation/common/svg_objects.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AnimatedLocaleIcon extends StatefulWidget {
  final bool isRu;

  const AnimatedLocaleIcon({super.key, required this.isRu});

  @override
  AnimatedLocaleIconState createState() => AnimatedLocaleIconState();
}

class AnimatedLocaleIconState extends State<AnimatedLocaleIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _currentIconPositionAnimation;
  late Animation<double> _nextIconPositionAnimation;
  late Animation<double> _currentIconOpacityAnimation;
  late Animation<double> _nextIconOpacityAnimation;

  bool _isAnimating = false;
  late bool _previousIsRu;

  @override
  void initState() {
    super.initState();
    _previousIsRu = widget.isRu;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _currentIconPositionAnimation = Tween<double>(begin: 0, end: -30).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _nextIconPositionAnimation = Tween<double>(begin: 30, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _currentIconOpacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _nextIconOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _previousIsRu = widget.isRu; // Обновить текущий флаг после завершения анимации
          _isAnimating = false; // Сброс флага анимации
        });
      }
    });
  }

  @override
  void didUpdateWidget(covariant AnimatedLocaleIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRu != oldWidget.isRu && !_isAnimating) {
      _isAnimating = true;
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Текущая иконка (улетает вверх и исчезает)
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _currentIconOpacityAnimation.value,
              child: Transform.translate(
                offset: Offset(0, _currentIconPositionAnimation.value),
                child: child,
              ),
            );
          },
          child: _previousIsRu ? const SvgRu() : const SvgUk(),
        ),
        // Следующая иконка (появляется снизу и занимает место)
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _nextIconOpacityAnimation.value,
              child: Transform.translate(
                offset: Offset(0, _nextIconPositionAnimation.value),
                child: child,
              ),
            );
          },
          child: widget.isRu ? const SvgRu() : const SvgUk(),
        ),
      ],
    );
  }
}