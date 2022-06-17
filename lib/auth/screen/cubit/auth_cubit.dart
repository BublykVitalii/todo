import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_theme/auth/domain/auth_service.dart';
import 'package:flutter_theme/screens/domain/todo_exceptions.dart';
import 'package:get_it/get_it.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState());
  AuthService get authService => GetIt.instance.get<AuthService>();

  void createAccount(String email, String password) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      await authService.createAccount(email, password);
      emit(state.copyWith(status: AuthStatus.success));
    } on TodoExceptions catch (error) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: error.toString(),
      ));
    }
  }

  void signIn(String email, String password) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      await authService.signIn(email, password);
      emit(state.copyWith(status: AuthStatus.success));
    } on TodoExceptions catch (error) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: error.toString(),
      ));
    }
  }

  void signInWithGoogle() async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      await authService.signInWithGoogle();
      emit(state.copyWith(status: AuthStatus.success));
    } on TodoExceptions catch (error) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: error.toString(),
      ));
    }
  }
}
