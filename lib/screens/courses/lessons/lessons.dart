import 'package:flutter/material.dart';
import 'package:ibs/model/course.dart';
import 'package:ibs/theme/style.dart';

class Lessons extends StatefulWidget {
  final CourseModel? course;
  const Lessons({Key? key, this.course}) : super(key: key);

  @override
  State<Lessons> createState() => _LessonsState();
}

class _LessonsState extends State<Lessons> {
  int pagesIndex = 0;

  Widget get title => Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Text(
          widget.course!.title,
          style: Style.headline5!.copyWith(fontSize: 30),
        ),
      );

  Widget get courseList => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: Style.padding16.copyWith(top: 0, bottom: 0),
            child: Text(
              "${widget.course!.coursesCount} ta dars (${widget.course!.duration} soat)",
              maxLines: 2,
              style: Style.body2.copyWith(fontSize: 18),
            ),
          ),
          const SizedBox(height: 10),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, index) => const SizedBox(),
            itemBuilder: (_, index) => videoContent(index),
            itemCount: widget.course!.courses.length,
          ),
        ],
      );

  Widget get contentAuthor => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Style.colors.yellow,
              ),
              padding: Style.padding12,
              child: Text(
                widget.course!.author[0],
                style: Style.body1,
              ),
            ),
            const SizedBox(width: 10),
            Text(widget.course!.author, style: Style.subtitle1),
            const Spacer(),
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 30,
                width: 100,
                decoration: BoxDecoration(
                  color: Style.colors.primary,
                  borderRadius: Style.border10,
                ),
                child: Center(
                    child: Text(
                  "obuna bo'lish",
                  style: Style.caption,
                )),
              ),
            )
          ],
        ),
      );

  Widget videoContent(int index) => TextButton(
        onPressed: () {
          if (index >= 2) {
            showDialog(
              context: context,
              builder: (BuildContext context) => Center(
                child: Container(
                  height: 300,
                  margin: Style.margin20,
                  padding: Style.padding20,
                  decoration: BoxDecoration(
                    color: Style.colors.white,
                    borderRadius: Style.border10,
                  ),
                  child: Center(
                    child: Text(
                      "Darslarni to'liq ko'ra olish uchun kursni sotib olishingiz zarur",
                      style: Style.body1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            );
            index = 0;
          }
          pagesIndex = index;
          setState(() {});
        },
        child: Container(
          padding: const EdgeInsets.only(left: 24),
          height: 48,
          width: double.infinity,
          color: pagesIndex == index
              ? Style.colors.primary
              : Style.colors.lightGrey,
          child: Row(
            children: [
              index == 0 || index == 1
                  ? Text(
                      "${index + 1}.",
                      style: TextStyle(
                          color: Style.colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w300),
                    )
                  : Icon(
                      Icons.lock_outline,
                      color: Style.colors.black,
                      size: 15,
                    ),
              const SizedBox(width: 25),
              Text(
                "${widget.course!.courses[index]["name"]}",
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                    color: Style.colors.black),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        title,
        const SizedBox(height: 20),
        const Divider(),
        contentAuthor,
        const Divider(),
        courseList,
      ],
    );
  }
}
