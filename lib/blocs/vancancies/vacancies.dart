import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibs/blocs/base/state.dart';
import 'package:ibs/model/vacancy.dart';

class VacanciesState extends SimpleGetState<List<VacancyModel>> {
  VacanciesState({
    bool fetching = false,
    List<VacancyModel>? vacancies,
    Exception? exception,
  }) : super(exception: exception, data: vacancies, fetching: fetching);
}

class VacanciesCubit extends Cubit<VacanciesState> {
  final _collectionRef = FirebaseFirestore.instance.collection('vacancies');

  VacanciesCubit() : super(VacanciesState());

  Future<void> fetchVacancies() async {
    emit(VacanciesState(fetching: true));

    try {
      List<VacancyModel> vacancies = [];
      QuerySnapshot querySnapshot = await _collectionRef.get();
      final vacanciesData = querySnapshot.docs.map((doc) {
        _collectionRef.doc(doc.id).update({"id": doc.id});

        return doc.data();
      }).toList();

      for (var story in vacanciesData) {
        vacancies.add(VacancyModel.fromJson(story as Map<String, dynamic>));
      }

      emit(VacanciesState(vacancies: vacancies));
    } on FirebaseAuthException catch (error) {
      emit(VacanciesState(exception: error));
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
