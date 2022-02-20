import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibs/blocs/courses/all_courses.dart';
import 'package:ibs/cells/action_sheet.dart';
import 'package:ibs/model/course.dart';
import 'package:ibs/screens/courses/course.dart';
import 'package:ibs/theme/style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseList extends StatelessWidget {
  final List<CourseModel> courses;
  final String title;
  const CourseList({
    Key? key,
    required this.title,
    required this.courses,
  }) : super(key: key);

  Color backgroundColor(int index) {
    late Color color;
    switch (courses[index].color) {
      case "violet":
        color = Style.colors.darkViolet;
        break;
      case "pink":
        color = Style.colors.pink;
        break;
      case "yellow":
        color = Style.colors.yellow;
        break;
      default:
        color = Style.colors.darkViolet;
    }
    return color;
  }

  void openCourse(BuildContext context, {int? index}) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (_) => CourseController(
          course: courses[index!],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        backgroundColor: Style.colors.black,
        trailing: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back,
                  color: Style.colors.white,
                ),
              ),
              const SizedBox(width: 20),
              Text(
                title,
                style: Style.body2
                    .copyWith(color: Style.colors.white, fontSize: 18),
              ),
              const Spacer(),
              ActionSheet(
                actions: [
                  ActionSheet.action(
                    onPressed: () {
                      context.read<CoursesCubit>().fetchCourses();
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Barchasi",
                      style: Style.body1.copyWith(fontSize: 18),
                    ),
                  ),
                  ActionSheet.action(
                    onPressed: () {
                      context.read<CoursesCubit>().sortCourses("programming");
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Dasturlash",
                      style: Style.body1.copyWith(fontSize: 18),
                    ),
                  ),
                  ActionSheet.action(
                    onPressed: () {
                      context.read<CoursesCubit>().sortCourses("designing");
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Dizaynerlik",
                      style: Style.body1.copyWith(fontSize: 18),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      child: BlocBuilder<CoursesCubit, CoursesState>(
        builder: (context, allCoursesState) {
          return allCoursesState.fetching
              ? const Center(child: CupertinoActivityIndicator())
              : ListView.separated(
                  physics: const ClampingScrollPhysics(),
                  padding: Style.padding12,
                  shrinkWrap: true,
                  itemCount: courses.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => openCourse(context, index: index),
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: Style.border10,
                              color: backgroundColor(index),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.play_circle_outline,
                                color: courses[index].color == "yellow"
                                    ? Style.colors.black
                                    : Style.colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                courses[index].title,
                                style: Style.body1.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(courses[index].author, style: Style.caption)
                            ],
                          )
                        ],
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
