import 'package:flutter/cupertino.dart';
import 'package:ibs/theme/style.dart';

class ActivityIndicator extends StatelessWidget {
  const ActivityIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CupertinoTheme(
        data: CupertinoTheme.of(context).copyWith(
          brightness: Style.appBrightness,
        ),
        child: const Center(
          child: CupertinoActivityIndicator(),
        ),
      );
}
