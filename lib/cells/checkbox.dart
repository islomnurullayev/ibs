import 'package:flutter/material.dart';
import 'package:ibs/theme/style.dart';

class Checkbox extends StatelessWidget {
  final bool value;
  final Widget child;
  final Function(bool)? onChanged;

  const Checkbox({
    Key? key,
    this.value = false,
    required this.child,
    @required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        children: [
          GestureDetector(
            onTap: () => onChanged!(!value),
            child: Container(
              width: 24.0,
              height: 24.0,
              decoration: BoxDecoration(
                border: value
                    ? null
                    : Border.all(color: Style.colors.grey, width: 2.0),
                borderRadius: BorderRadius.circular(4.0),
                color: value ? Style.colors.primary : null,
              ),
              child: value
                  ? Icon(
                      Icons.check,
                      color: Style.colors.white,
                      size: 16.0,
                    )
                  : null,
            ),
          ),
          // ignore: unnecessary_null_comparison
          if (child != null) ...[const SizedBox(width: 8.0), child],
        ],
      );
}
