import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibs/blocs/base/state.dart';
import 'package:ibs/model/course.dart';

class RecommendedCoursesState extends SimpleGetState<List<CourseModel>> {
  RecommendedCoursesState({
    bool fetching = false,
    List<CourseModel>? courses,
    Exception? exception,
  }) : super(exception: exception, data: courses, fetching: fetching);
}

class RecommendedCoursesCubit extends Cubit<RecommendedCoursesState> {
  RecommendedCoursesCubit() : super(RecommendedCoursesState());
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('courses');

  Future<void> fetchCourses() async {
    emit(RecommendedCoursesState(fetching: true));
    try {
      List<CourseModel> courses = [];

      DocumentSnapshot<Object?> querySnapshot =
          await _collectionRef.doc("all").get();

      for (var snapshot in querySnapshot["data"] as List) {
        snapshot as Map<String, dynamic>;

        if (snapshot["recommended"]) {
          courses.add(CourseModel.fromJson(snapshot));
        }
      }

      emit(RecommendedCoursesState(courses: courses));
    } on FirebaseException catch (error) {
      emit(RecommendedCoursesState(exception: error));
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
