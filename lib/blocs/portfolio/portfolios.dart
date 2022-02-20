import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibs/blocs/base/state.dart';
import 'package:ibs/model/portfolio.dart';

class PortfoliosState extends SimpleGetState<List<PortfolioModel>> {
  String? uid;
  PortfoliosState({
    this.uid,
    bool fetching = false,
    List<PortfolioModel>? portfolios,
    Exception? exception,
  }) : super(exception: exception, data: portfolios, fetching: fetching);
}

class PortfoliosCubit extends Cubit<PortfoliosState> {
  PortfoliosCubit() : super(PortfoliosState());
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('portfolios');

  Future<void> fetchPortfolios() async {
    emit(PortfoliosState(fetching: true));
    try {
      List<PortfolioModel> portfolios = [];
      String? uid;
      QuerySnapshot querySnapshot = await _collectionRef.get();
      final portfoliosData =
          querySnapshot.docs.map((doc) => doc.data()).toList();

      for (var portfolio in portfoliosData) {
        PortfolioModel data = PortfolioModel.fromJson(
          portfolio as Map<String, dynamic>,
        );

        portfolios.add(data);
      }

      emit(PortfoliosState(portfolios: portfolios, uid: uid));
    } on FirebaseException catch (error) {
      emit(PortfoliosState(exception: error));
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
