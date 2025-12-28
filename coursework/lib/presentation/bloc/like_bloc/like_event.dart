abstract class LikeEvent {
  const LikeEvent();
}

class LoadLikesEvent extends LikeEvent {
  const LoadLikesEvent();
}

class ChangeLikeEvent extends LikeEvent {
  final int id;

  const ChangeLikeEvent(this.id);
}
