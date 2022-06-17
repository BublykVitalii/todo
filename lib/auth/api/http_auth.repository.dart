import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_theme/auth/domain/auth_repository.dart';
import 'package:flutter_theme/utils/store_interaction.dart';

@Singleton(as: AuthRepository)
class HttpAuthRepository implements AuthRepository {
  HttpAuthRepository(this._preference);

  final authTodo = FirebaseAuth.instance;
  final StoreInteraction _preference;
  final todoCollection = FirebaseFirestore.instance;
  @override
  Future<void> createAccount(String email, String password) async {
    try {
      final credential = await authTodo.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final token = credential.user!.uid;
      await _preference.setToken(token);
      todoCollection.collection(token);
    } on FirebaseAuthException catch (error) {
      if (error.code == 'weak-password') {
        throw AssertionError('The password provided is too weak.');
      } else if (error.code == 'email-already-in-use') {
        throw AssertionError('The account already exists for that email.');
      }
    }
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      final credential = await authTodo.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final token = credential.user!.uid;
      await _preference.setToken(token);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AssertionError('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw AssertionError('Wrong password provided for that user.');
      }
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await authTodo.signOut();
      await _preference.clear();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final idToken = googleUser?.id;
    await _preference.setToken(idToken ?? '');
    todoCollection.collection(idToken ?? '');
    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Future<bool> inLoggedIn() async {
    final sessionId = await _preference.getToken();
    return sessionId.isNotEmpty;
  }
}
