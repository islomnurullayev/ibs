import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibs/screens/courses/lessons/image.dart';
import 'package:ibs/theme/style.dart';

class Projects extends StatelessWidget {
  final dynamic projects;
  const Projects({Key? key, this.projects}) : super(key: key);

  void openImage(BuildContext context, {String? url}) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => FullImage(url: url!),
      ),
    );
  }

  Widget title(String title) => Padding(
        padding: Style.padding16.copyWith(top: 0, bottom: 0),
        child: Text(
          title,
          maxLines: 2,
          style: Style.headline5!.copyWith(fontWeight: FontWeight.bold),
        ),
      );

  Widget get description => Padding(
        padding: Style.padding16.copyWith(top: 0, bottom: 0),
        child: Text(
          projects["description"],
          maxLines: 2,
          style: Style.body1,
        ),
      );

  Widget portfolio(BuildContext context, int index) => GestureDetector(
        onTap: () => openImage(context, url: projects["portfolios"][index]),
        child: Hero(
          tag: "image",
          child: ClipRRect(
            borderRadius: Style.border10,
            child: Image.network(
              projects["portfolios"][index],
              width: 160,
              height: 60,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: Style.border10,
                    color: Style.colors.grey.withOpacity(0.3),
                  ),
                  width: 160,
                  height: 60,
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );

  Widget get portfolios => SizedBox(
        height: 120,
        child: ListView.separated(
          padding: Style.padding16.copyWith(top: 0),
          scrollDirection: Axis.horizontal,
          itemBuilder: portfolio,
          separatorBuilder: (_, index) => const SizedBox(width: 10),
          itemCount: projects["portfolios"].length,
        ),
      );

  Widget get resources => ListView.separated(
        shrinkWrap: true,
        primary: false,
        padding: Style.padding16.copyWith(top: 0),
        itemCount: projects["resources"].length,
        separatorBuilder: (_, index) => const SizedBox(height: 10),
        itemBuilder: (_, index) => Container(
          padding: Style.padding16,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: Style.border10,
            color: Style.colors.grey.withOpacity(0.3),
          ),
          child: Row(
            children: [
              Icon(
                CupertinoIcons.link,
                size: 20,
                color: Style.colors.black,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    projects["resources"][index]["name"],
                    style: Style.body1,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    projects["resources"][index]["size"],
                    style: Style.caption,
                  ),
                ],
              ),
              const Spacer(),
              Icon(
                CupertinoIcons.cloud_download,
                color: Style.colors.black,
              )
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
        title("Talabalarning ishlari"),
        const SizedBox(height: 16),
        portfolios,
        const SizedBox(height: 20),
        title("Proyekt haqida"),
        const SizedBox(height: 16),
        description,
        const SizedBox(height: 30),
        title("Resurslar"),
        const SizedBox(height: 16),
        resources,
      ],
    );
  }
}
