import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibs/blocs/base/state.dart';
import 'package:ibs/model/course.dart';

class SavedCoursesState extends SimpleGetState<List<CourseModel>> {
  SavedCoursesState({
    bool fetching = false,
    List<CourseModel>? courses,
    Exception? exception,
  }) : super(exception: exception, data: courses, fetching: fetching);
}

class SavedCoursesCubit extends Cubit<SavedCoursesState> {
  SavedCoursesCubit() : super(SavedCoursesState());
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('courses');

  Future<void> fetchCourses() async {
    emit(SavedCoursesState(fetching: true));
    try {
      List<CourseModel> courses = [];

      DocumentSnapshot<Object?> querySnapshot =
          await _collectionRef.doc("all").get();

      for (var snapshot in querySnapshot["data"] as List) {
        snapshot as Map<String, dynamic>;

        if (snapshot["saved"]) {
          courses.add(CourseModel.fromJson(snapshot));
        }
      }

      emit(SavedCoursesState(courses: courses));
    } on FirebaseException catch (error) {
      emit(SavedCoursesState(exception: error));
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
