import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibs/blocs/base/state.dart';
import 'package:ibs/model/user.dart';

class UserState extends SimpleGetState<UserModel> {
  UserState({
    bool fetching = false,
    UserModel? user,
    Exception? exception,
  }) : super(exception: exception, data: user, fetching: fetching);
}

class UserCubit extends Cubit<UserState> {
  final _userCollection = FirebaseFirestore.instance.collection('users');
  final _auth = FirebaseAuth.instance;

  UserCubit() : super(UserState());

  Future<void> fetchUser() async {
    emit(UserState(fetching: true));

    try {
      _userCollection.doc(_auth.currentUser!.uid.trim()).get().then(
        (doc) {
          var user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
          emit(UserState(user: user));
        },
      ).catchError((error) {
        emit(UserState(exception: error));
      });
    } on FirebaseAuthException catch (error) {
      emit(UserState(exception: error));
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
