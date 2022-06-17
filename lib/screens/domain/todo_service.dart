import 'package:flutter_theme/screens/domain/todo.dart';
import 'package:flutter_theme/screens/domain/todo_repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class TodoService {
  TodoService(this._todoRepository);

  final TodoRepository _todoRepository;

  Todo? _todo;
  Todo? get todo => _todo;


  Future addNewTodo(String note) async {
    _todo = await _todoRepository.addNewTodo(note);
    return _todo;
  }

  Future changeTodo(String note, String id) async {
    _todo = await _todoRepository.changeTodo(note, id);
    return _todo;
  }

  Future deleteTodo(String id) async {
    _todo = await _todoRepository.deleteTodo(id);
    return _todo;
  }

  Future updateTodo(String id, bool complete) async {
    _todo = await _todoRepository.updateTodo(
      id,
      complete,
    );
    return _todo;
  }

  Future<List<Todo>> fromFirestore() async {
    return await _todoRepository.todoFromFirestore();
  }
}
