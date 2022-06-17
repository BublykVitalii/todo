abstract class AuthRepository {
  Future<void> createAccount(String email, String password);
  Future<void> signIn(String email, String password);
  Future<void> logOut();
  Future<void> signInWithGoogle();
  Future<bool> inLoggedIn();
}
