import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_theme/screens/domain/todo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo_dto.g.dart';

@JsonSerializable()
class TodoDTO {
  final bool complete;
  final String id;
  final String userIdToken;
  final String note;
  final String? title;
  final List<TodoDTO> todos;
  const TodoDTO(
    this.complete,
    this.id,
    this.userIdToken,
    this.note,
    this.title,
    this.todos,
  );

  Todo toTodo() {
    return Todo(
      title ?? '',
      id,
      userIdToken,
      complete: complete,
      note: note,
    );
  }

  static Todo fromTodo(Todo todo) {
    return Todo(
      todo.title,
      todo.id,
      todo.userIdToken,
      complete: todo.complete,
      note: todo.note,
    );
  }

  Map<String, dynamic> toJson() => _$TodoDTOToJson(this);

  factory TodoDTO.fromJson(Map<String, dynamic> json) =>
      _$TodoDTOFromJson(json);

  List<Todo> toTodos() {
    return todos.map((todo) => todo.toTodo()).toList();
  }

  static TodoDTO fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    return TodoDTO(
      doc.data()!['complete'],
      doc.id,
      doc.data()!['userIdToken'],
      doc.data()!['note'],
      doc.data()!['title'],
      doc.data()!['todos'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'complete': complete,
      'title': title ?? '',
      'note': note,
    };
  }
}
