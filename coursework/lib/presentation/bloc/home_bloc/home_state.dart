import 'package:candystore/models/home_data.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final HomeData? data;
  final bool isLoading;
  final bool isPaginationLoading;
  final String? error;

  const HomeState(
      {this.data, this.isLoading = false, this.isPaginationLoading = false, this.error});

  // Получение нового экземпляра состояния
  HomeState copyWith(
          {HomeData? data, bool? isLoading, bool? isPaginationLoading, String? error}) =>
      HomeState(
          data: data ?? this.data,
          isLoading: isLoading ?? this.isLoading,
          isPaginationLoading: isPaginationLoading ?? this.isPaginationLoading,
          error: error ?? this.error);

  // Поля, по которым Equtable сравнивает состояния
  @override
  List<Object?> get props => [data, isLoading, isPaginationLoading, error];
}
