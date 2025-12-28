import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmd/data/repositories/mock_repository.dart';
import 'package:pmd/data/repositories/potter_repository.dart';
import 'package:pmd/presentation/bloc/events.dart';
import 'package:pmd/presentation/bloc/state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PotterRepository repository;

  // final MockRepository repository;

  HomeBloc(this.repository) : super(const HomeState()) {
    on<HomeLoadDataEvent>(_onLoadData);
  }

  Future<void> _onLoadData(HomeLoadDataEvent event, Emitter<HomeState> emit) async {
    if (event.nextPage == null) {
      emit(state.copyWith(isLoading: true));
    } else {
      emit(state.copyWith(isPaginationLoading: true));
    }

    String? error;

    final data = await repository.loadData(
        q: event.search, page: event.nextPage ?? 1, onError: (e) => error = e);

    if (event.nextPage != null) {
      data?.data?.insertAll(0, state.data?.data ?? []);
    }

    emit(state.copyWith(isLoading: false, isPaginationLoading: false, data: data, error: error));
  }
}
