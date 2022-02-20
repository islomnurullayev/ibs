import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibs/blocs/resources/resource.dart';
import 'package:ibs/theme/style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResourcesController extends StatefulWidget {
  final String? uid;
  const ResourcesController({Key? key, this.uid}) : super(key: key);

  @override
  State<ResourcesController> createState() => _ResourcesControllerState();
}

class _ResourcesControllerState extends State<ResourcesController> {
  late String filter;

  @override
  void initState() {
    filter = "Barchasi";
    fetchResources();
    super.initState();
  }

  void fetchResources() {
    context.read<ResourceCubit>().fetchResouce(widget.uid!);
  }

  void showActionSheet(ResourceState state) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: List.generate(
          state.data!.filter.length,
          (index) => CupertinoActionSheetAction(
            onPressed: () {
              filter = state.data!.filter[index];
              Navigator.of(context).pop();
              setState(() {});
            },
            child: Text(
              state.data!.filter[index].toUpperCase(),
              style: Style.body2,
            ),
          ),
        ),
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            "Orqaga",
            style: Style.body1.copyWith(
              color: Style.colors.error,
              fontSize: 20,
            ),
          ),
          isDestructiveAction: true,
        ),
      ),
    );
  }

  Color backgroundColor(String colorKey) {
    late Color color;
    switch (colorKey) {
      case "violet":
        color = Style.colors.blue;
        break;
      case "green":
        color = Style.colors.lightGreen;
        break;
      case "pink":
        color = Style.colors.darkViolet;
        break;
      default:
        color = Style.colors.violet;
    }
    return color;
  }

  Widget actionButton(ResourceState state) => GestureDetector(
        onTap: () => showActionSheet(state),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: Style.padding8,
              width: 150,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: Style.border10,
                border: Border.all(color: Style.colors.black),
              ),
              child: Row(
                children: [
                  Text(filter, style: Style.body2),
                  const Spacer(),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Style.colors.black,
                  )
                ],
              ),
            ),
          ],
        ),
      );

  Widget get topics => BlocBuilder<ResourceCubit, ResourceState>(
        builder: (context, state) {
          return ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, index) => Container(
              height: 120,
              padding: Style.padding16,
              decoration: BoxDecoration(
                borderRadius: Style.border10,
                color: backgroundColor(state.data!.color),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.data!.topics[index]["title"],
                    style: Style.body1.copyWith(color: Style.colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    state.data!.topics[index]["name"],
                    style: Style.headline5!.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Style.colors.white),
                  ),
                  const SizedBox(height: 10),
                  state.data!.topics[index]["level"] != null
                      ? Text(
                          state.data!.topics[index]["level"],
                          style: Style.body1.copyWith(
                            color: Style.colors.white,
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
            separatorBuilder: (_, index) => const SizedBox(height: 10),
            itemCount: state.data!.topics.length,
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResourceCubit, ResourceState>(
      builder: (context, state) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            automaticallyImplyLeading: false,
            backgroundColor: Style.colors.black,
            trailing: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back,
                      color: Style.colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Padding(
                    child: Image.asset("assets/images/logo.png"),
                    padding: Style.padding8,
                  )
                ],
              ),
            ),
          ),
          child: state.fetching
              ? const Center(child: CupertinoActivityIndicator())
              : ListView(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  padding: Style.padding16,
                  children: [
                    Text(
                      state.data!.name,
                      style: Style.headline5!.copyWith(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(state.data!.caption, style: Style.body1),
                    const SizedBox(height: 20),
                    actionButton(state),
                    const SizedBox(height: 20),
                    topics,
                  ],
                ),
        );
      },
    );
  }
}
