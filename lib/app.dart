import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibs/blocs/auth/login.dart';
import 'package:ibs/blocs/courses/all_courses.dart';
import 'package:ibs/blocs/courses/recommended_courses.dart';
import 'package:ibs/blocs/courses/saved_courses.dart';
import 'package:ibs/blocs/courses/viewed_courses.dart';
import 'package:ibs/blocs/portfolio/portfolios.dart';
import 'package:ibs/blocs/resources/resource.dart';
import 'package:ibs/blocs/resources/resources.dart';
import 'package:ibs/blocs/stories.dart';
import 'package:ibs/blocs/user.dart';
import 'package:ibs/blocs/vancancies/vacancies.dart';
import 'package:ibs/screens/home.dart';
import 'package:ibs/screens/auth/login.dart';
import 'package:ibs/theme/style.dart';
import 'package:ibs/theme/theme.dart';
import 'package:ibs/blocs/portfolio/portfolio.dart';

class IbsApp extends StatelessWidget {
  const IbsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginCubit()),
        BlocProvider(create: (_) => UserCubit()),
        BlocProvider(create: (_) => StoriesCubit()),
        BlocProvider(create: (_) => PortfoliosCubit()),
        BlocProvider(create: (_) => PortfolioCubit()),
        BlocProvider(create: (_) => SavedCoursesCubit()),
        BlocProvider(create: (_) => CoursesCubit()),
        BlocProvider(create: (_) => ViewedCoursesCubit()),
        BlocProvider(create: (_) => RecommendedCoursesCubit()),
        BlocProvider(create: (_) => ResourcesCubit()),
        BlocProvider(create: (_) => ResourceCubit()),
        BlocProvider(create: (_) => VacanciesCubit()),
      ],
      child: CupertinoApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        localizationsDelegates: const [
          DefaultMaterialLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        home: CupertinoPageScaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Style.colors.white,
          child: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (_, snapshot) => snapshot.hasData
                ? const HomeController()
                : const LoginController(),
          ),
        ),
      ),
    );
  }
}
