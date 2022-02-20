import 'package:flutter/material.dart';
import 'package:ibs/model/course.dart';
import 'package:ibs/theme/style.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class CourseCard extends StatelessWidget {
  final CourseModel course;
  final Function()? onTap;
  final Function()? onSaved;
  const CourseCard({Key? key, required this.course, this.onTap, this.onSaved})
      : super(key: key);

  Color get backgroundColor {
    late Color color;
    switch (course.color) {
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

  Widget get indicator => StepProgressIndicator(
        totalSteps: 100,
        currentStep: course.progress,
        padding: 0,
        selectedColor: Style.colors.primary,
        unselectedColor:
            course.progress > 0 ? Style.colors.black : Style.colors.grey,
      );

  Widget get header => Expanded(
        child: Container(
          padding: Style.padding12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: course.color == "yellow"
                      ? Style.colors.black
                      : Style.colors.white,
                  borderRadius: Style.border10,
                ),
                child: Text(
                  course.type.toUpperCase().trim(),
                  style: Style.caption!.copyWith(
                    color: backgroundColor,
                    fontSize: 10,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                course.title.toUpperCase(),
                style: Style.headline6.copyWith(
                  fontWeight: FontWeight.w600,
                  color: course.color == "yellow"
                      ? Style.colors.black
                      : Style.colors.white,
                  fontSize: 24,
                ),
              )
            ],
          ),
        ),
      );

  Widget get footer => Container(
        width: 240,
        height: 60,
        padding: Style.padding8,
        decoration: BoxDecoration(
          color: Style.colors.white,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.author,
                  style: Style.body2.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  "${course.coursesCount} dars, ${course.duration} soat",
                  style: Style.caption,
                )
              ],
            ),
            const Spacer(),
            IconButton(
              onPressed: onSaved,
              icon: Icon(
                course.saved ? Icons.bookmark : Icons.bookmark_border,
                size: 24,
                color: Style.colors.black,
              ),
            ),
          ],
        ),
      );

  Widget get view => GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: Style.border10,
          ),
          child: Container(
            width: 240,
            height: 200,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: Style.border10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header,
                indicator,
                footer,
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return view;
  }
}
