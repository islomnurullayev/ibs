import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibs/blocs/base/state.dart';
import 'package:ibs/model/course.dart';

class CoursesState extends SimpleGetState<List<CourseModel>> {
  CoursesState({
    bool fetching = false,
    List<CourseModel>? courses,
    Exception? exception,
  }) : super(exception: exception, data: courses, fetching: fetching);
}

class CoursesCubit extends Cubit<CoursesState> {
  CoursesCubit() : super(CoursesState());
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('courses');

  Future<void> fetchCourses() async {
    emit(CoursesState(fetching: true));
    try {
      List<CourseModel> courses = [];

      DocumentSnapshot<Object?> querySnapshot =
          await _collectionRef.doc("all").get();

      for (var snapshot in querySnapshot["data"] as List) {
        courses.add(CourseModel.fromJson(snapshot as Map<String, dynamic>));
      }

      emit(CoursesState(courses: courses));
    } on FirebaseException catch (error) {
      emit(CoursesState(exception: error));
    }
  }

  Future<void> sortCourses(String field) async {
    emit(CoursesState(fetching: true));
    try {
      List<CourseModel> courses = [];

      DocumentSnapshot<Object?> querySnapshot =
          await _collectionRef.doc("all").get();

      for (var snapshot in querySnapshot["data"] as List) {
        snapshot as Map<String, dynamic>;

        if (snapshot["field"] == field) {
          courses.add(CourseModel.fromJson(snapshot));
        }
      }

      emit(CoursesState(courses: courses));
    } on FirebaseException catch (error) {
      emit(CoursesState(exception: error));
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
