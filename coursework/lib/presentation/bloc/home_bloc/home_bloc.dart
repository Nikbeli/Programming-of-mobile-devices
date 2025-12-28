import 'package:candystore/data/repositories/candy_repository.dart';
import 'package:candystore/presentation/bloc/home_bloc/home_event.dart';
import 'package:candystore/presentation/bloc/home_bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CandyRepository repository;

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
