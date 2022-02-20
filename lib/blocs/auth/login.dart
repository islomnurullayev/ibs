import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibs/blocs/base/state.dart';
import 'package:ibs/services/preferences.dart';

class LoginState extends SimpleGetState<String> {
  LoginState({
    bool fetching = false,
    String? token,
    Exception? exception,
  }) : super(exception: exception, data: token, fetching: fetching);
}

class LoginCubit extends Cubit<LoginState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  LoginCubit() : super(LoginState());

  Future<String> login(String email, String password) async {
    emit(LoginState(fetching: true));

    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      if (await Preferences.setToken(user!.uid)) {
        emit(LoginState(token: user.uid));
      } else {
        emit(LoginState(exception: Exception("Cannot save token")));
      }
      emit(LoginState(fetching: false));
      return user.uid;
    } on FirebaseAuthException catch (error) {
      emit(LoginState(exception: error));
      return "";
    }
  }

  Future<void> signup(String email, String password) async {
    emit(LoginState(fetching: true));

    try {
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .set({'email': email, "password": password});

      emit(LoginState(token: user.uid));
    } on FirebaseAuthException catch (error) {
      emit(LoginState(exception: error));
    }
  }

  Future<Future<List>> signOut() async {
    return Future.wait([_firebaseAuth.signOut()]);
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
