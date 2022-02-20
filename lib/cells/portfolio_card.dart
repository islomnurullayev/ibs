import 'package:flutter/material.dart';
import 'package:ibs/model/portfolio.dart';
import 'package:ibs/theme/style.dart';

class PortfolioCard extends StatelessWidget {
  final Function() onTap;
  final PortfolioModel portfolio;
  const PortfolioCard({
    Key? key,
    required this.onTap,
    required this.portfolio,
  }) : super(key: key);

  Widget get categoryWidget => Row(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 24, top: 8),
            width: 27,
            height: 27,
            color: Style.colors.black,
            child: Icon(
              Icons.play_arrow_rounded,
              color: Style.colors.primary,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              border: Border.all(color: Style.colors.black),
              color: Style.colors.white,
            ),
            width: 73,
            height: 27,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                portfolio.type,
                style: Style.caption,
              ),
            ),
          ),
        ],
      );

  Widget get footer => Container(
        height: 60,
        decoration: BoxDecoration(
          color: Style.colors.black,
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        padding: const EdgeInsets.only(left: 30, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              portfolio.title,
              style: Style.body1.copyWith(color: Style.colors.white),
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Style.colors.yellow,
                  ),
                  padding: Style.padding4,
                  child: Text(portfolio.name[0]),
                ),
                const SizedBox(width: 10),
                Text(
                  portfolio.name,
                  style: Style.caption!.copyWith(color: Style.colors.white),
                ),
              ],
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 15,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Stack(
          children: [
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: Image.network(portfolio.contents.first).image,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            Positioned(top: 10, right: 20, child: categoryWidget),
            Positioned(bottom: 0, right: 0, left: 0, child: footer),
          ],
        ),
      ),
    );
  }
}
