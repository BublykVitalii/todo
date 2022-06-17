import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_theme/screens/domain/todo.dart';
import 'package:flutter_theme/screens/domain/todo_exceptions.dart';
import 'package:flutter_theme/screens/domain/todo_service.dart';
import 'package:get_it/get_it.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(const TodoState());
  TodoService get todoService => GetIt.instance.get<TodoService>();

  void addNote(String note) async {
    try {
      emit(state.copyWith(status: TodoStatus.loading));
      await todoService.addNewTodo(note);
      emit(state.copyWith(status: TodoStatus.success));
    } on TodoExceptions catch (error) {
      emit(state.copyWith(
        status: TodoStatus.error,
        errorMessage: error.toString(),
      ));
    }
  }

  void fromFirestore() async {
    try {
      emit(state.copyWith(status: TodoStatus.loading));
      final list = await todoService.fromFirestore();
      emit(state.copyWith(
        status: TodoStatus.success,
        listTitle: list,
      ));
    } on TodoExceptions catch (error) {
      emit(state.copyWith(
        status: TodoStatus.error,
        errorMessage: error.toString(),
      ));
    }
  }

  void deleteTodo(String id) async {
    try {
      emit(state.copyWith(status: TodoStatus.loading));
      await todoService.deleteTodo(id);
      final list = await todoService.fromFirestore();
      emit(state.copyWith(
        status: TodoStatus.success,
        listTitle: list,
      ));
    } on TodoExceptions catch (error) {
      emit(state.copyWith(
        status: TodoStatus.error,
        errorMessage: error.toString(),
      ));
    }
  }

  void changeNote(String note, String id) async {
    try {
      emit(state.copyWith(status: TodoStatus.loading));
      await todoService.changeTodo(note, id);
      final list = await todoService.fromFirestore();
      emit(state.copyWith(
        status: TodoStatus.success,
        listTitle: list,
      ));
    } on TodoExceptions catch (error) {
      emit(state.copyWith(
        status: TodoStatus.error,
        errorMessage: error.toString(),
      ));
    }
  }

  void updateTodo(String id, bool complete) async {
    try {
      emit(state.copyWith(status: TodoStatus.loading));
      await todoService.updateTodo(id, complete);
      final list = await todoService.fromFirestore();
      emit(state.copyWith(
        status: TodoStatus.success,
        listTitle: list,
      ));
    } on TodoExceptions catch (error) {
      emit(state.copyWith(
        status: TodoStatus.error,
        errorMessage: error.toString(),
      ));
    }
  }
}
