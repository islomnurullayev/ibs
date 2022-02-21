import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibs/blocs/user.dart';
import 'package:ibs/screens/auth/login.dart';
import 'package:ibs/screens/courses/courses.dart';
import 'package:ibs/screens/dashboard/dashboard.dart';
import 'package:ibs/screens/process.dart';
import 'package:ibs/screens/profile/profile.dart';
import 'package:ibs/screens/vacancies/vacancies.dart';
import 'package:ibs/screens/webinar.dart';
import 'package:ibs/theme/style.dart';

class HomeController extends StatefulWidget {
  const HomeController({Key? key}) : super(key: key);

  @override
  _HomeControllerState createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {
  void openLoginPage() {
    Navigator.of(context).pushAndRemoveUntil(
      CupertinoPageRoute(builder: (_) => const LoginController()),
      (_) => false,
    );
  }

  /// --- Widgets ---

  Widget buildItem(int index) {
    switch (index) {
      case 0:
        return const DashboardController();
      case 1:
        return const Courses();
      case 2:
        return const VacanciesController();
      case 3:
        return const Community();
      case 4:
        return const ProfileController();
      default:
        return const ProcessScreen();
    }
  }

  List<BottomNavigationBarItem> get tabItems => const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined)),
        BottomNavigationBarItem(icon: Icon(Icons.play_circle_outline_outlined)),
        BottomNavigationBarItem(icon: Icon(Icons.business_center_outlined)),
        BottomNavigationBarItem(icon: Icon(Icons.people_alt_outlined)),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline_sharp)),
      ];

  CupertinoTabBar get tabBar => CupertinoTabBar(
        iconSize: 30.0,
        items: tabItems,
        activeColor: Style.colors.primary,
        inactiveColor: Style.colors.grey,
        backgroundColor: Style.colors.black,
      );

  Widget get tabScaffold => CupertinoTabScaffold(
        backgroundColor: Style.colors.white,
        tabBar: tabBar,
        tabBuilder: (_, index) => buildItem(index),
      );

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
        child: BlocBuilder<UserCubit, UserState>(
          buildWhen: (_, state) => state.fetching || state.data != null,
          builder: (_, state) => tabScaffold,
        ),
      );
}
