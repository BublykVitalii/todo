import 'package:flutter_theme/auth/domain/auth_repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthService {
  AuthService(this._authRepository);
  final AuthRepository _authRepository;

  Future<void> createAccount(String email, String password) async {
    await _authRepository.createAccount(email, password);
  }

  Future<void> signIn(String email, String password) async {
    return await _authRepository.signIn(email, password);
  }

  Future<void> logOut() async {
    _authRepository.logOut();
  }

  Future<void> signInWithGoogle() async {
    _authRepository.signInWithGoogle();
  }

  Future<bool> inLoggedIn() async {
    return await _authRepository.inLoggedIn();
  }
}
