import 'package:candystore/presentation/bloc/like_bloc/like_event.dart';
import 'package:candystore/presentation/bloc/like_bloc/like_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _likedPrefsKey = "liked";

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  LikeBloc() : super(const LikeState(likedIds: [])) {
    on<ChangeLikeEvent>(_onChangeLike);
    on<LoadLikesEvent>(_onLoadLikes);
  }

  Future<void> _onLoadLikes(LoadLikesEvent event, Emitter<LikeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_likedPrefsKey);

    // Преобразуем список строк в список целых чисел
    final likedIds = data?.map(int.parse).toList() ?? [];

    emit(state.copyWith(likedIds: likedIds));
  }

  Future<void> _onChangeLike(ChangeLikeEvent event, Emitter<LikeState> emit) async {
    final updatedList = List<int>.from(state.likedIds ?? []);

    if (updatedList.contains(event.id)) {
      updatedList.remove(event.id);
    } else {
      updatedList.add(event.id);
    }

    final prefs = await SharedPreferences.getInstance();

    // Преобразуем список целых чисел обратно в строки перед сохранением
    prefs.setStringList(_likedPrefsKey, updatedList.map((id) => id.toString()).toList());

    emit(state.copyWith(likedIds: updatedList));
  }
}
