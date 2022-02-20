import 'package:flutter/material.dart';
import 'package:ibs/model/stories.dart';
import 'package:ibs/theme/style.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

class StoryPageController extends StatelessWidget {
  final List<StoryItem> storyItems;
  final StoryController storyController;
  final StoryModel story;
  const StoryPageController({
    Key? key,
    required this.storyItems,
    required this.storyController,
    required this.story,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          StoryView(
            storyItems: storyItems,
            onComplete: () {
              Navigator.pop(context);
            },
            progressPosition: ProgressPosition.top,
            repeat: false,
            controller: storyController,
          ),
          Positioned(
            top: 30,
            left: 20,
            child: SafeArea(
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Style.colors.black,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: Image.network(story.avatar).image,
                          fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        story.name,
                        style: Style.body1.copyWith(
                          color: Style.colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        story.role,
                        style: Style.body2.copyWith(
                          color: Style.colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
