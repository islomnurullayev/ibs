import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibs/blocs/base/state.dart';
import 'package:ibs/model/portfolio.dart';

class PortfolioState extends SimpleGetState<PortfolioModel> {
  PortfolioState({
    bool fetching = false,
    PortfolioModel? portfolio,
    Exception? exception,
  }) : super(exception: exception, data: portfolio, fetching: fetching);
}

class PortfolioCubit extends Cubit<PortfolioState> {
  PortfolioCubit() : super(PortfolioState());
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('portfolios');

  Future<void> viewCount(String? uid) async {
    emit(PortfolioState(fetching: true));
    try {
      PortfolioModel? portfolio;

      await _collectionRef.doc(uid).get().then((value) {
        portfolio =
            PortfolioModel.fromJson(value.data() as Map<String, dynamic>);
      });

      await _collectionRef
          .doc(uid)
          .set({"viewed": FieldValue.increment(1)}, SetOptions(merge: true));

      emit(PortfolioState(portfolio: portfolio));
    } on FirebaseException catch (error) {
      emit(PortfolioState(exception: error));
    }
  }

  Future<void> addComment(uid, {List? data}) async {
    _collectionRef.doc(uid).update({"comments": data}).onError(
      (error, stackTrace) => Exception(error),
    );
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
