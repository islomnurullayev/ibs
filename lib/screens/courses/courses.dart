import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibs/blocs/courses/all_courses.dart';
import 'package:ibs/blocs/courses/recommended_courses.dart';
import 'package:ibs/blocs/courses/saved_courses.dart';
import 'package:ibs/blocs/courses/viewed_courses.dart';
import 'package:ibs/blocs/resources/resources.dart';
import 'package:ibs/blocs/user.dart';
import 'package:ibs/cells/course_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibs/model/course.dart';
import 'package:ibs/screens/courses/course.dart';
import 'package:ibs/screens/courses/course_list.dart';
import 'package:ibs/screens/resources/resources.dart';
import 'package:ibs/theme/style.dart';

class Courses extends StatefulWidget {
  const Courses({Key? key}) : super(key: key);

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  @override
  void initState() {
    fetchCourses();
    context.read<UserCubit>().fetchUser();
    super.initState();
  }

  void fetchCourses() {
    context.read<CoursesCubit>().fetchCourses();
    context.read<SavedCoursesCubit>().fetchCourses();
    context.read<ViewedCoursesCubit>().fetchCourses();
    context.read<RecommendedCoursesCubit>().fetchCourses();
    context.read<ResourcesCubit>().fetchResouces();
  }

  Color backgroundColor(String colorKey) {
    late Color color;
    switch (colorKey) {
      case "violet":
        color = Style.colors.violet;
        break;
      case "green":
        color = Style.colors.lightGreen;
        break;
      case "pink":
        color = Style.colors.pink;
        break;
      default:
        color = Style.colors.violet;
    }
    return color;
  }

  void openList({String? title, List<CourseModel>? courses}) {
    Navigator.of(context).push(CupertinoPageRoute(
      builder: (context) => CourseList(
        title: title!,
        courses: courses!,
      ),
    ));
  }

  Widget title(String title, {List<CourseModel>? courses}) => Padding(
        padding: Style.padding16.copyWith(top: 0, bottom: 0),
        child: Row(
          children: [
            Text(
              title,
              maxLines: 2,
              style: Style.headline5!.copyWith(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Material(
              borderRadius: Style.border20,
              color: Style.colors.transparent,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Style.colors.black,
                ),
                onPressed: () => openList(title: title, courses: courses),
              ),
            )
          ],
        ),
      );

  Widget get allCourses => BlocBuilder<CoursesCubit, CoursesState>(
        builder: (context, state) {
          return SizedBox(
            height: 255,
            child: state.fetching
                ? const CupertinoActivityIndicator()
                : Column(
                    children: [
                      title("Barcha kurslar", courses: state.data),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.separated(
                          padding: Style.padding16.copyWith(top: 0, bottom: 0),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) => CourseCard(
                            course: state.data![index],
                            onSaved: () async {
                              state.data![index].saved =
                                  !state.data![index].saved;

                              setState(() {});
                            },
                            onTap: () => Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (_) => CourseController(
                                  course: state.data![index],
                                ),
                              ),
                            ),
                          ),
                          separatorBuilder: (_, index) =>
                              const SizedBox(width: 10),
                          itemCount: state.data!.length,
                        ),
                      ),
                    ],
                  ),
          );
        },
      );

  Widget get savedCourses => BlocBuilder<SavedCoursesCubit, SavedCoursesState>(
        builder: (context, state) {
          return SizedBox(
            height: 255,
            child: state.fetching
                ? const CupertinoActivityIndicator()
                : Column(
                    children: [
                      title("Saqlangan kurslar", courses: state.data),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.separated(
                          padding: Style.padding16.copyWith(top: 0, bottom: 0),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) => CourseCard(
                            course: state.data![index],
                            onSaved: () async {
                              state.data![index].saved =
                                  !state.data![index].saved;

                              setState(() {});
                            },
                            onTap: () => Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (_) => CourseController(
                                  course: state.data![index],
                                ),
                              ),
                            ),
                          ),
                          separatorBuilder: (_, index) =>
                              const SizedBox(width: 10),
                          itemCount: state.data!.length,
                        ),
                      ),
                    ],
                  ),
          );
        },
      );

  Widget get viewedCourses =>
      BlocBuilder<ViewedCoursesCubit, ViewedCoursesState>(
        builder: (context, state) {
          return SizedBox(
            height: 255,
            child: state.fetching
                ? const CupertinoActivityIndicator()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      title("Davom etish", courses: state.data),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          padding: Style.padding16.copyWith(top: 0, bottom: 0),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) => CourseCard(
                            course: state.data![index],
                            onSaved: () async {
                              state.data![index].saved =
                                  !state.data![index].saved;

                              setState(() {});
                            },
                            onTap: () => Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (_) => CourseController(
                                  course: state.data![index],
                                ),
                              ),
                            ),
                          ),
                          separatorBuilder: (_, index) =>
                              const SizedBox(width: 10),
                          itemCount: state.data!.length,
                        ),
                      ),
                    ],
                  ),
          );
        },
      );

  Widget get recommendedCourses =>
      BlocBuilder<RecommendedCoursesCubit, RecommendedCoursesState>(
        builder: (context, state) {
          return SizedBox(
            height: 255,
            child: state.fetching
                ? const CupertinoActivityIndicator()
                : Column(
                    children: [
                      title("Tavsiya etiladigan kurslar", courses: state.data),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.separated(
                          padding: Style.padding16.copyWith(top: 0, bottom: 0),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) => CourseCard(
                            course: state.data![index],
                            onSaved: () async {
                              state.data![index].saved =
                                  !state.data![index].saved;

                              setState(() {});
                            },
                            onTap: () => Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (_) => CourseController(
                                  course: state.data![index],
                                ),
                              ),
                            ),
                          ),
                          separatorBuilder: (_, index) =>
                              const SizedBox(width: 10),
                          itemCount: state.data!.length,
                        ),
                      ),
                    ],
                  ),
          );
        },
      );

  Widget get usefulRecources => BlocBuilder<ResourcesCubit, ResourcesState>(
        builder: (context, state) {
          return state.fetching
              ? const CupertinoActivityIndicator()
              : SizedBox(
                  height: 120,
                  child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemCount: state.data!.length,
                    padding: Style.padding16.copyWith(top: 0),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) => GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (_) =>
                              ResourcesController(uid: state.data![index].id),
                        ),
                      ),
                      child: Container(
                        padding: Style.padding12,
                        child: Center(
                          child: Text(
                            state.data![index].name,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                              color: Style.colors.white,
                            ),
                          ),
                        ),
                        width: 174,
                        height: 98,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: backgroundColor(state.data![index].color),
                        ),
                      ),
                    ),
                  ),
                );
        },
      );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return state.fetching
            ? const CupertinoActivityIndicator()
            : CupertinoPageScaffold(
                child: SafeArea(
                  child: RefreshIndicator(
                    onRefresh: () async => fetchCourses(),
                    child: ListView(
                      physics: const ClampingScrollPhysics(),
                      children: [
                        Padding(
                          padding: Style.padding16.copyWith(bottom: 0),
                          child: Text(
                            "Salom ${state.data!.firstName!}!",
                            maxLines: 2,
                            style: Style.body1.copyWith(fontSize: 20),
                          ),
                        ),
                        viewedCourses,
                        savedCourses,
                        allCourses,
                        recommendedCourses,
                        const SizedBox(height: 15),
                        Padding(
                          padding: Style.padding16.copyWith(top: 0, bottom: 0),
                          child: Text(
                            "Foydali resurslar",
                            maxLines: 2,
                            style: Style.headline5!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 20),
                        usefulRecources
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}
