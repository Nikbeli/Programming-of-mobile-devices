import 'dart:async';
import 'dart:ui';

class Debounce {
  // Фабричный конструктор, возвращающий экзепляр класса Debounce. Паттерн Singleton
  factory Debounce() => _instance;

  // Приватный конструктор (Не даёт создание класса извне)
  Debounce._();

  // Статический экземпляр класса
  static final Debounce _instance = Debounce._();

  static Timer? _timer;

  // Статический метод, где action функция, совершающая действие, а delay совершает задержку)
  static void run(
      {required VoidCallback action, Duration delay = const Duration(milliseconds: 500)}) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }
}
