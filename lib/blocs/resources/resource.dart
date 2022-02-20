import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibs/blocs/base/state.dart';
import 'package:ibs/model/resources.dart';

class ResourceState extends SimpleGetState<ResourceModel> {
  ResourceState({
    bool fetching = false,
    ResourceModel? resources,
    Exception? exception,
  }) : super(exception: exception, data: resources, fetching: fetching);
}

class ResourceCubit extends Cubit<ResourceState> {
  final _collectionRef = FirebaseFirestore.instance.collection('resources');

  ResourceCubit() : super(ResourceState());

  Future<void> fetchResouce(String uid) async {
    emit(ResourceState(fetching: true));

    try {
      ResourceModel? resource;

      await _collectionRef.doc(uid).get().then((value) {
        resource = ResourceModel.fromJson(value.data() as Map<String, dynamic>);
      });

      emit(ResourceState(resources: resource));
    } on FirebaseAuthException catch (error) {
      emit(ResourceState(exception: error));
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
