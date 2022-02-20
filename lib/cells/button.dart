import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibs/theme/style.dart';

enum ButtonType {
  primary,
  text,
}

class Button extends StatelessWidget {
  final ButtonType? type;
  final Function() onPressed;
  final Color? color;
  final Color? iconColor;
  final ShapeBorder? shape;
  final Widget? child;
  final String text;
  final IconData? icon;
  final double? iconSize;
  final double? minWidth;
  final EdgeInsets? padding;
  final bool spinner;

  const Button.primary({
    Key? key,
    this.color,
    this.child,
    this.text = "",
    required this.onPressed,
    this.padding,
    this.spinner = false,
  })  : type = ButtonType.primary,
        shape = null,
        icon = null,
        iconColor = null,
        minWidth = null,
        iconSize = null,
        super(key: key);

  const Button.text({
    key,
    this.color,
    this.child,
    this.text = "",
    this.padding,
    required this.onPressed,
    this.spinner = false,
  })  : type = ButtonType.text,
        shape = null,
        icon = null,
        iconColor = null,
        minWidth = null,
        iconSize = null,
        super(key: key);

  Widget get calculatedChild {
    late Widget widget;
    switch (type!) {
      case ButtonType.primary:
        widget = Text(
          text,
          style: Style.button.copyWith(color: Style.colors.white),
        );
        break;

      case ButtonType.text:
        widget = Text(
          text,
          style: Style.button.copyWith(color: Style.colors.primary),
        );
        break;
    }
    return widget;
  }

  @override
  Widget build(BuildContext context) => MaterialButton(
        elevation: 0,
        highlightElevation: 0,
        minWidth: minWidth,
        disabledColor: Style.colors.grey,
        padding: padding ?? Style.padding12,
        color: color ?? type!.color,
        shape: shape ?? type!.shape,
        child: spinner
            ? const CupertinoActivityIndicator()
            : child ?? calculatedChild,
        onPressed: onPressed,
      );
}

extension on ButtonType {
  Color get color {
    late Color color;
    switch (this) {
      case ButtonType.primary:
        color = Style.colors.primary;
        break;
      case ButtonType.text:
        color = Style.colors.transparent;
        break;
    }
    return color;
  }

  ShapeBorder get shape {
    ShapeBorder shape;
    switch (this) {
      case ButtonType.primary:
        shape = RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        );
        break;

      case ButtonType.text:
        shape = RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        );
        break;
    }
    return shape;
  }
}
