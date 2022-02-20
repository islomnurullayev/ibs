import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibs/blocs/portfolio/portfolio.dart';
import 'package:ibs/blocs/user.dart';
import 'package:ibs/model/portfolio.dart';
import 'package:ibs/theme/style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PortfolioController extends StatefulWidget {
  final PortfolioModel? portfolio;
  final String? uid;
  const PortfolioController({
    Key? key,
    this.portfolio,
    this.uid,
  }) : super(key: key);

  @override
  State<PortfolioController> createState() => _PortfolioControllerState();
}

class _PortfolioControllerState extends State<PortfolioController> {
  final commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<PortfolioCubit>().viewCount(widget.uid);
    context.read<UserCubit>().fetchUser();
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  Widget get categoryWidget => Padding(
        padding: const EdgeInsets.only(left: 16, top: 20),
        child: Row(
          children: [
            Container(
              width: 35,
              height: 40,
              color: Style.colors.black,
              child: Icon(
                Icons.play_arrow_rounded,
                color: Style.colors.primary,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                border: Border.all(color: Style.colors.black),
                color: Style.colors.white,
              ),
              width: 100,
              height: 40,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  widget.portfolio!.type,
                  style: Style.caption,
                ),
              ),
            ),
          ],
        ),
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
              padding: Style.padding16,
              child: Text(
                widget.portfolio!.name[0],
                style: Style.headline5,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.portfolio!.name, style: Style.subtitle1),
                Text(widget.portfolio!.role, style: Style.body2),
              ],
            ),
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

  Widget get contents => ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (_, index) => SizedBox(
          height: 300,
          child: Image.network(
            widget.portfolio!.contents[index],
            fit: BoxFit.cover,
          ),
        ),
        itemCount: widget.portfolio!.contents.length,
      );

  Widget get title => Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Text(
          widget.portfolio!.title,
          style: Style.headline5!.copyWith(fontSize: 30),
        ),
      );

  Widget get views => BlocBuilder<PortfolioCubit, PortfolioState>(
        builder: (context, state) {
          return state.fetching
              ? const CupertinoActivityIndicator()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.thumb_up,
                        color: Style.colors.black,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        state.data!.likes.toString(),
                        style:
                            Style.body1.copyWith(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 20),
                      Icon(
                        Icons.visibility,
                        color: Style.colors.black,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        state.data!.viewed.toString(),
                        style:
                            Style.body1.copyWith(fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      Text(
                        DateFormat('dd/MM/yyyy')
                            .format(DateTime.fromMillisecondsSinceEpoch(
                              state.data!.createdAt.millisecondsSinceEpoch,
                            ))
                            .toString(),
                        style:
                            Style.body1.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                );
        },
      );

  Widget get description => BlocBuilder<PortfolioCubit, PortfolioState>(
        builder: (context, state) {
          return state.fetching && state.data == null
              ? const CupertinoActivityIndicator()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    state.data!.description,
                    style: Style.body2,
                  ),
                );
        },
      );

  Widget get comments => BlocBuilder<PortfolioCubit, PortfolioState>(
        builder: (context, state) {
          return state.fetching
              ? const CupertinoActivityIndicator()
              : ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.data!.comments.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                  state.data!.comments[index]["author"][0],
                                  style: Style.body2.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    color: Style.colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "${state.data!.comments[index]["author"]}:  ",
                            style: Style.body2.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${state.data!.comments[index]["message"]}",
                              style: Style.body2.copyWith(
                                fontWeight: FontWeight.w300,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
        },
      );

  Widget get textField => BlocBuilder<UserCubit, UserState>(
        builder: (context, userState) {
          return BlocBuilder<PortfolioCubit, PortfolioState>(
            builder: (context, portfolioState) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: Style.border20,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ClipRRect(
                  borderRadius: Style.border20,
                  child: CupertinoTextField(
                    controller: commentController,
                    padding: Style.padding12,
                    cursorColor: Style.colors.black,
                    style: Style.body1,
                    placeholder: "Komment qoldirish",
                    suffix: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: GestureDetector(
                        child: Icon(Icons.send, color: Style.colors.black),
                        onTap: () {
                          portfolioState.data!.comments.insert(
                            0,
                            {
                              "message": commentController.text.trim(),
                              "author":
                                  "${userState.data!.firstName} ${userState.data!.lastName}"
                            },
                          );
                          context.read<PortfolioCubit>().addComment(
                                widget.uid,
                                data: portfolioState.data!.comments,
                              );

                          commentController.clear();

                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      );

  CupertinoNavigationBar get navigationBar => const CupertinoNavigationBar();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: navigationBar,
      child: SafeArea(
        bottom: false,
        child: ListView(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.only(bottom: 20),
          children: [
            categoryWidget,
            const SizedBox(height: 20),
            title,
            const SizedBox(height: 20),
            contentAuthor,
            const SizedBox(height: 10),
            contents,
            const SizedBox(height: 20),
            title,
            const SizedBox(height: 15),
            views,
            const SizedBox(height: 10),
            description,
            const SizedBox(height: 30),
            comments,
            const SizedBox(height: 10),
            textField,
          ],
        ),
      ),
    );
  }
}
