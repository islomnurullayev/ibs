import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibs/blocs/base/state.dart';
import 'package:ibs/model/stories.dart';

class StoriesState extends SimpleGetState<List<StoryModel>> {
  StoriesState({
    bool fetching = false,
    List<StoryModel>? stories,
    Exception? exception,
  }) : super(exception: exception, data: stories, fetching: fetching);
}

class StoriesCubit extends Cubit<StoriesState> {
  StoriesCubit() : super(StoriesState());
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('stories');

  Future<void> fetchStories() async {
    emit(StoriesState(fetching: true));
    try {
      List<StoryModel> stories = [];
      QuerySnapshot querySnapshot = await _collectionRef.get();
      final storiesData = querySnapshot.docs.map((doc) => doc.data()).toList();

      for (var story in storiesData) {
        stories.add(StoryModel.fromJson(story as Map<String, dynamic>));
      }

      emit(StoriesState(stories: stories));
    } on FirebaseException catch (error) {
      emit(StoriesState(exception: error));
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
