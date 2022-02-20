import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibs/blocs/base/state.dart';
import 'package:ibs/model/resources.dart';

class ResourcesState extends SimpleGetState<List<ResourceModel>> {
  ResourcesState({
    bool fetching = false,
    List<ResourceModel>? resources,
    Exception? exception,
  }) : super(exception: exception, data: resources, fetching: fetching);
}

class ResourcesCubit extends Cubit<ResourcesState> {
  final _collectionRef = FirebaseFirestore.instance.collection('resources');

  ResourcesCubit() : super(ResourcesState());

  Future<void> fetchResouces() async {
    emit(ResourcesState(fetching: true));

    try {
      List<ResourceModel> resources = [];
      QuerySnapshot querySnapshot = await _collectionRef.get();
      final resourcesData = querySnapshot.docs.map((doc) {
        _collectionRef.doc(doc.id).update({"id": doc.id});

        return doc.data();
      }).toList();

      for (var story in resourcesData) {
        resources.add(ResourceModel.fromJson(story as Map<String, dynamic>));
      }

      emit(ResourcesState(resources: resources));
    } on FirebaseAuthException catch (error) {
      emit(ResourcesState(exception: error));
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
