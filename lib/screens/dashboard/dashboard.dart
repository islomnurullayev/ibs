import 'package:flutter/cupertino.dart';
import 'package:ibs/blocs/portfolio/portfolios.dart';
import 'package:ibs/blocs/stories.dart';
import 'package:ibs/cells/activity_indicator.dart';
import 'package:ibs/cells/portfolio_card.dart';
import 'package:ibs/cells/stories/story.dart';
import 'package:ibs/cells/stories/story_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibs/screens/portfolio.dart';
import 'package:ibs/theme/style.dart';
import 'package:story_view/story_view.dart';

class DashboardController extends StatefulWidget {
  const DashboardController({Key? key}) : super(key: key);

  @override
  State<DashboardController> createState() => _DashboardControllerState();
}

class _DashboardControllerState extends State<DashboardController> {
  final storyController = StoryController();

  @override
  void initState() {
    context.read<StoriesCubit>().fetchStories();
    context.read<PortfoliosCubit>().fetchPortfolios();
    super.initState();
  }

  void openStoryView(int index, StoriesState state) {
    Navigator.of(context).push(CupertinoPageRoute(
      builder: (_) => StoryPageController(
        storyController: storyController,
        story: state.data![index],
        storyItems: List<StoryItem>.generate(
          state.data![index].contentUrl.length,
          (i) => storyItem(
            state.data![index].contentUrl[i],
          ),
        ),
      ),
    ));
  }

  StoryItem storyItem(String url, {String? caption}) => StoryItem.pageImage(
        url: url,
        caption: caption,
        controller: storyController,
      );

  Widget get stories => BlocBuilder<StoriesCubit, StoriesState>(
        builder: (_, state) {
          return state.fetching
              ? const ActivityIndicator()
              : SizedBox(
                  height: 120,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (_, index) => const SizedBox(width: 20),
                    itemCount: state.data!.length,
                    itemBuilder: (_, index) => Story(
                        story: state.data![index],
                        onTap: () => openStoryView(index, state)),
                  ),
                );
        },
      );

  Widget get courses => BlocBuilder<PortfoliosCubit, PortfoliosState>(
        builder: (context, state) {
          return state.fetching
              ? const CupertinoActivityIndicator()
              : ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (_, __) => const SizedBox(height: 15),
                  itemCount: state.data!.length,
                  shrinkWrap: true,
                  itemBuilder: (_, index) => PortfolioCard(
                    portfolio: state.data![index],
                    onTap: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (_) => PortfolioController(
                            portfolio: state.data![index],
                            uid: state.data![index].id.trim(),
                          ),
                        ),
                      );
                    },
                  ),
                );
        },
      );

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: ListView(
          physics: const ClampingScrollPhysics(),
          padding: Style.padding16,
          shrinkWrap: true,
          children: [
            stories,
            courses,
          ],
        ),
      ),
    );
  }
}
