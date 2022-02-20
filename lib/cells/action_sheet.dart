import 'package:flutter/cupertino.dart';
import 'package:ibs/theme/style.dart';

class ActionSheet extends StatelessWidget {
  final String? actionMessage;
  final String? actionTitle;
  final List<CupertinoActionSheetAction> actions;

  const ActionSheet({
    Key? key,
    required this.actions,
    this.actionMessage = "",
    this.actionTitle = "",
  }) : super(key: key);

  static CupertinoActionSheetAction action({
    required Function() onPressed,
    required Widget child,
    bool isDefaultAction = false,
    bool isDestructiveAction = false,
  }) =>
      CupertinoActionSheetAction(
        onPressed: onPressed,
        child: child,
        isDefaultAction: isDefaultAction,
        isDestructiveAction: isDestructiveAction,
      );

  void showActionSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: actions,
        title: actionTitle!.isNotEmpty ? Text(actionTitle!) : null,
        message: actionMessage!.isNotEmpty ? Text(actionMessage!) : null,
        cancelButton: action(
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showActionSheet(context),
      child: Icon(
        CupertinoIcons.slider_horizontal_3,
        size: 24,
        color: Style.colors.white,
      ),
    );
  }
}
