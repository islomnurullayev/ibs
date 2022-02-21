import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibs/theme/style.dart';

class Community extends StatefulWidget {
  const Community({Key? key}) : super(key: key);

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  List<String> roles = [
    "Dasturchi",
    "Dizayner",
    "3D dizayner",
  ];

  List<Color> roleColors = [
    Style.colors.blue,
    Style.colors.pink,
    Style.colors.yellow,
  ];

  Color backgroundColor(String role) {
    late Color color;
    switch (role) {
      case "coder":
        color = Style.colors.blue;
        break;
      case "designer":
        color = Style.colors.pink;
        break;
      case "3d":
        color = Style.colors.yellow;
        break;
      default:
        color = Style.colors.blue;
    }
    return color;
  }

  Widget get roleList => SizedBox(
        height: 40,
        child: ListView.separated(
          padding: Style.padding16.copyWith(top: 10, bottom: 0),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) => Container(
            padding: Style.padding4,
            decoration: BoxDecoration(
              color: roleColors[index],
              borderRadius: Style.border20,
            ),
            child: Center(
              child: FittedBox(
                fit: BoxFit.none,
                child: Text(
                  roles[index],
                  style: Style.caption!.copyWith(
                    color: index == 2 ? Style.colors.black : Style.colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          separatorBuilder: (_, index) => const SizedBox(width: 10),
          itemCount: 3,
        ),
      );

  Widget get webinarList => SizedBox(
        height: 145,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: Style.padding16.copyWith(top: 10, bottom: 0),
          itemBuilder: (_, index) => GestureDetector(
            onTap: () {},
            child: Container(
              height: 140,
              width: 230,
              decoration: BoxDecoration(
                borderRadius: Style.border20,
                image: DecorationImage(
                  image: Image.asset('assets/images/webinar_page.png').image,
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                height: 32,
                width: 32,
                margin: const EdgeInsets.all(50),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Style.colors.black,
                ),
                child: Center(
                  child: Icon(
                    Icons.play_arrow_rounded,
                    color: Style.colors.primary,
                  ),
                ),
              ),
            ),
          ),
          separatorBuilder: (_, __) => const SizedBox(width: 10),
          itemCount: 2,
        ),
      );

  Widget get blogList => SizedBox(
        height: 155,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: Style.padding16.copyWith(top: 10, bottom: 0),
          itemBuilder: (_, index) => GestureDetector(
            onTap: () {},
            child: Container(
              width: 230,
              decoration: BoxDecoration(
                borderRadius: Style.border20,
                color: Style.colors.pink,
              ),
              padding: Style.padding16,
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                reverse: true,
                shrinkWrap: true,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Style.colors.white,
                        ),
                        child: Center(child: Text("A", style: Style.body2)),
                      ),
                      const SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Abdurashid',
                            style: Style.caption!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: Style.colors.white,
                            ),
                          ),
                          Text(
                            'Zaxurov',
                            style: Style.caption!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: Style.colors.white,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Vector va raster\ngrafika farqi!',
                    style: Style.body1.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Style.colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/square.png',
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(width: 5),
                      Image.asset(
                        'assets/images/square.png',
                        width: 20,
                        height: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
          separatorBuilder: (_, __) => const SizedBox(width: 10),
          itemCount: 2,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Style.colors.white,
      child: SafeArea(
        child: ListView(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Container(
              height: 260,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: Image.asset('assets/images/webinar.png').image,
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Style.colors.primary,
                  ),
                  height: 31,
                  width: 152,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "chatga qo'shilish",
                      style: Style.body1,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: Style.padding16.copyWith(top: 0, bottom: 0),
              child: Text(
                'Filtrlash',
                style: Style.body1.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            roleList,
            Container(
              padding: Style.padding16.copyWith(top: 20, bottom: 0),
              child: Text(
                'Webinar',
                style: Style.headline5!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            webinarList,
            Container(
              padding: Style.padding16.copyWith(top: 20, bottom: 0),
              child: Text(
                'Blog',
                style: Style.headline5!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 230,
                      decoration: BoxDecoration(
                        borderRadius: Style.border20,
                        color: Style.colors.pink,
                      ),
                      padding: Style.padding16,
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        reverse: true,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Style.colors.white,
                                ),
                                child: Center(
                                    child: Text("A", style: Style.body2)),
                              ),
                              const SizedBox(width: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Abdurashid',
                                    style: Style.caption!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      color: Style.colors.white,
                                    ),
                                  ),
                                  Text(
                                    'Zaxurov',
                                    style: Style.caption!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      color: Style.colors.white,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Vector va raster\ngrafika farqi!',
                            style: Style.body1.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Style.colors.white,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/images/square.png',
                                width: 20,
                                height: 20,
                              ),
                              const SizedBox(width: 5),
                              Image.asset(
                                'assets/images/square.png',
                                width: 20,
                                height: 20,
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 230,
                      decoration: BoxDecoration(
                        borderRadius: Style.border20,
                        color: Style.colors.blue,
                      ),
                      padding: Style.padding16,
                      child: ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        reverse: true,
                        shrinkWrap: true,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Style.colors.white,
                                ),
                                child: Center(
                                    child: Text("M", style: Style.body2)),
                              ),
                              const SizedBox(width: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Mariam',
                                    style: Style.caption!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      color: Style.colors.white,
                                    ),
                                  ),
                                  Text(
                                    'Tuxtasunov',
                                    style: Style.caption!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      color: Style.colors.white,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Axios orqali backend’dan\nma‘lumotni olish',
                            style: Style.body2.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Style.colors.white,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(
                                Icons.arrow_forward_rounded,
                                color: Style.colors.black,
                                size: 22,
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: Style.padding16.copyWith(top: 20, bottom: 0),
              child: Text(
                'Natijalar',
                style: Style.headline5!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 234,
                    height: 136,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Style.colors.black),
                    child: Center(
                        child: Text(
                      'Moyshikdan frontend\ndasturchilikkacha',
                      style: Style.body1
                          .copyWith(color: Style.colors.primary, fontSize: 20),
                    )),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 234,
                    height: 136,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Style.colors.black,
                    ),
                    child: Center(
                        child: Text(
                      '1000\$lik ishimni\ntashlab keldim',
                      style: Style.body1
                          .copyWith(color: Style.colors.primary, fontSize: 20),
                    )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
