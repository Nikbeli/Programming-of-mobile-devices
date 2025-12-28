import 'package:equatable/equatable.dart';

class LikeState extends Equatable {
  final List<int>? likedIds;

  const LikeState({required this.likedIds});

  LikeState copyWith({List<int>? likedIds}) => LikeState(likedIds: likedIds ?? this.likedIds);

  @override
  List<Object?> get props => [likedIds];
}
