part of 'todo_cubit.dart';

enum TodoStatus {
  initial,
  loading,
  success,
  error,
}

class TodoState extends Equatable {
  final TodoStatus status;
  final String? errorMessage;
  final List<Todo>? listTitle;
  final Todo? title;

  const TodoState({
    this.status = TodoStatus.initial,
    this.errorMessage,
    this.listTitle,
    this.title,
  });

  TodoState copyWith({
    TodoStatus? status,
    String? errorMessage,
    List<Todo>? listTitle,
    Todo? title,
  }) {
    return TodoState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      listTitle: listTitle ?? this.listTitle,
      title: title ?? this.title,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        listTitle,
        title,
      ];
}
