import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_theme/screens/domain/todo.dart';
import 'package:flutter_theme/screens/domain/todo_exceptions.dart';
import 'package:flutter_theme/screens/domain/todo_repository.dart';
import 'package:flutter_theme/utils/store_interaction.dart';

@Singleton(as: TodoRepository)
class FirebaseTodoRepository implements TodoRepository {
  FirebaseTodoRepository(this._preference);

  final StoreInteraction _preference;

  @override
  Future addNewTodo(String note) async {
    try {
      final token = await _preference.getToken();
      await FirebaseFirestore.instance.collection(token).add({
        'note': note,
        'complete': false,
      });
    } on DioError catch (error) {
      if (error.response == null) {
        throw const TodoExceptions();
      }
      rethrow;
    }
  }

  @override
  Future deleteTodo(String id) async {
    try {
      final token = await _preference.getToken();
      await FirebaseFirestore.instance.collection(token).doc(id).delete();
    } on DioError catch (error) {
      if (error.response == null) {
        throw const TodoExceptions();
      }
      rethrow;
    }
  }

  @override
  Future changeTodo(String note, String id) async {
    try {
      final token = await _preference.getToken();
      await FirebaseFirestore.instance
          .collection(token)
          .doc(id)
          .update({'note': note});
    } on DioError catch (error) {
      if (error.response == null) {
        throw const TodoExceptions();
      }
      rethrow;
    }
  }

  @override
  Future updateTodo(String id, bool complete) async {
    final token = await _preference.getToken();
    await FirebaseFirestore.instance
        .collection(token)
        .doc(id)
        .update({"complete": complete});
  }

  @override
  Future<List<Todo>> todoFromFirestore() async {
    try {
      final token = await _preference.getToken();
      final todos = await FirebaseFirestore.instance
          .collection(token)
          .get()
          .then((snapshot) {
        return snapshot.docs.map((e) {
          return Todo(
            e.data()['title'] ?? '',
            e.id,
            e.data()['userIdToken'] ?? 'userID',
            complete: e.data()['complete'],
            note: e.data()['note'],
          );
        }).toList();
      });
      return todos;
    } on DioError catch (error) {
      if (error.response == null) {
        throw const TodoExceptions();
      }
      rethrow;
    }
  }
}
