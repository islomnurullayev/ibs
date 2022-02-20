import 'package:flutter/cupertino.dart';

class FullImage extends StatelessWidget {
  final String url;
  const FullImage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(),
      child: Hero(
        tag: "image",
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.network(url).image,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
