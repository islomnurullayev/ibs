import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibs/theme/style.dart';

class CourseComments extends StatelessWidget {
  final dynamic comments;
  const CourseComments({Key? key, this.comments}) : super(key: key);

  String dayAgo(int index) {
    int month = comments[index]["days_ago"] ~/ 60;
    return comments[index]["days_ago"] >= 60
        ? "$month oy oldin"
        : "${comments[index]["days_ago"]} kun oldin";
  }

  Widget comment(int index) => Card(
        elevation: 1,
        child: Padding(
          padding: Style.padding12,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Style.colors.yellow,
                ),
                width: 25,
                height: 25,
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.none,
                    child: Text(
                      comments[index]["name"][0],
                      style: Style.body2.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Style.colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comments[index]["name"],
                      style: Style.body2.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Style.colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      comments[index]["message"],
                      style: Style.body2.copyWith(
                        fontWeight: FontWeight.w100,
                        fontSize: 14,
                        color: Style.colors.black,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.hand_thumbsup,
                          color: Style.colors.black,
                        ),
                        const SizedBox(width: 10),
                        Icon(
                          CupertinoIcons.chat_bubble,
                          color: Style.colors.black,
                        ),
                        const SizedBox(width: 20),
                        Text(
                          dayAgo(index),
                          style: Style.body2.copyWith(
                            fontWeight: FontWeight.w100,
                            fontSize: 14,
                            color: Style.colors.black,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          CupertinoIcons.hand_thumbsup,
                          color: Style.colors.black,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "${comments[index]["likes"]}",
                          style: Style.body2.copyWith(
                            fontWeight: FontWeight.w100,
                            fontSize: 14,
                            color: Style.colors.black,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget get commentsList => ListView.separated(
        itemBuilder: (_, index) => comment(index),
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (_, index) => Container(),
        itemCount: comments.length,
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: Style.padding16.copyWith(top: 0, bottom: 0),
          child: Text(
            "${comments.length} ta xabar....",
            maxLines: 2,
            style: Style.body2.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        commentsList,
      ],
    );
  }
}
