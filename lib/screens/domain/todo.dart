class Todo {
  final bool complete;
  final String id;
  final String userIdToken;
  final String note;
  final String title;

  const Todo(
    this.title,
    this.id,
    this.userIdToken, {
    this.complete = false,
    this.note = '',
  });

  Todo copyWith({
    bool? complete,
    String? id,
    String? userIdToken,
    String? note,
    String? title,
  }) {
    return Todo(
      title ?? this.title,
      id ?? this.id,
      userIdToken ?? this.userIdToken,
      complete: complete ?? this.complete,
      note: note ?? this.note,
    );
  }

  @override
  int get hashCode =>
      complete.hashCode ^
      title.hashCode ^
      note.hashCode ^
      id.hashCode ^
      userIdToken.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Todo &&
          runtimeType == other.runtimeType &&
          complete == other.complete &&
          title == other.title &&
          note == other.note &&
          id == other.id &&
          userIdToken == other.userIdToken;

  @override
  String toString() {
    return 'Todo { complete: $complete, title: $title, note: $note, id: $id ,userIdToken: $userIdToken,}';
  }

  List<Object?> get props => [
        complete,
        id,
        note,
        title,
        userIdToken,
      ];
}
