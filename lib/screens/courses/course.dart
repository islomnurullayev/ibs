import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibs/cells/video_player.dart';
import 'package:ibs/model/course.dart';
import 'package:ibs/screens/courses/comments/comments.dart';
import 'package:ibs/screens/courses/lessons/lessons.dart';
import 'package:ibs/screens/courses/projects/projects.dart';
import 'package:ibs/theme/style.dart';
import 'package:video_player/video_player.dart';

class CourseController extends StatefulWidget {
  final CourseModel course;
  const CourseController({Key? key, required this.course}) : super(key: key);

  @override
  State<CourseController> createState() => _CourseControllerState();
}

class _CourseControllerState extends State<CourseController> {
  late VideoPlayerController controller;
  late Future<void> initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    controller = VideoPlayerController.network(
      widget.course.courses.first["url"]!.trim(),
    );

    initializeVideoPlayerFuture = controller.initialize();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget tabTitle(String title) => Tab(
        child: Text(
          title,
          style: Style.body1.copyWith(color: Style.colors.white),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(),
      child: Material(
        child: DefaultTabController(
          length: 3,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                Center(
                  child: VideoPlayerWidget(
                    controller: controller,
                    initializeVideoPlayerFuture: initializeVideoPlayerFuture,
                  ),
                ),
                Container(
                  color: Style.colors.black,
                  child: TabBar(
                    indicatorColor: Style.colors.primary,
                    indicatorWeight: 5,
                    tabs: [
                      tabTitle("Darslar"),
                      tabTitle("Proyekt"),
                      tabTitle("Muloqot"),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 1000,
                  child: TabBarView(
                    children: [
                      Lessons(course: widget.course),
                      Projects(projects: widget.course.projects),
                      CourseComments(comments: widget.course.comments),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
