import 'package:flutter/material.dart';
import 'package:ibs/model/stories.dart';
import 'package:ibs/theme/style.dart';

class Story extends StatelessWidget {
  final StoryModel story;
  final Function() onTap;
  const Story({
    Key? key,
    required this.story,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Card(
            elevation: 8,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Style.colors.black,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Style.colors.primary,
                  width: 2,
                ),
                image: DecorationImage(
                  image: Image.network(story.avatar).image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            story.name,
            style: Style.caption!.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
