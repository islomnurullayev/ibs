// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:ibs/theme/style.dart';

class TextInputField extends StatefulWidget {
  final String? placeholder;
  final String? title;
  final String error;
  final bool obscureText;
  final bool autofocus;
  final bool autocorrect;
  final bool readonly;
  final TextEditingController? controller;
  final ValueChanged<String>? onChange;
  final GestureTapCallback? onTap;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  final int? maxLines;
  final int? minLines;

  const TextInputField({
    @required this.controller,
    Key? key,
    this.placeholder,
    this.title,
    this.error = "",
    this.autofocus = false,
    this.autocorrect = false,
    this.readonly = false,
    this.onChange,
    this.onTap,
    this.keyboardType = TextInputType.text,
    this.focusNode,
    this.suffixIcon,
    this.maxLines = 1,
    this.minLines = 1,
  })  : obscureText = false,
        super(key: key);

  const TextInputField.obscure({
    Key? key,
    this.placeholder,
    this.title,
    this.error = "",
    this.autofocus = false,
    this.autocorrect = false,
    this.readonly = false,
    @required this.controller,
    this.onChange,
    this.onTap,
    this.keyboardType = TextInputType.text,
    this.focusNode,
    this.suffixIcon,
    this.maxLines = 1,
    this.minLines = 1,
  })  : obscureText = true,
        super(key: key);

  const TextInputField.large({
    @required this.controller,
    Key? key,
    this.placeholder,
    this.title,
    this.error = "",
    this.autofocus = false,
    this.autocorrect = false,
    this.readonly = false,
    this.onChange,
    this.onTap,
    this.keyboardType = TextInputType.text,
    this.focusNode,
    this.suffixIcon,
    this.maxLines,
  })  : obscureText = false,
        minLines = 5,
        super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _TextInputFieldState createState() => _TextInputFieldState(
        focusNode ?? FocusNode(),
        obscureText,
        autofocus,
      );
}

class _TextInputFieldState extends State<TextInputField> {
  FocusNode focusNode;
  bool obscureText;
  bool focused;

  _TextInputFieldState(
    this.focusNode,
    this.obscureText,
    this.focused,
  );

  get borderWidth => widget.error.isNotEmpty || focused ? 1.0 : 0.0;

  get borderColor => widget.error.isNotEmpty
      ? Style.colors.error
      : (focused ? Style.colors.primary : Style.colors.lightBackground);

  late bool isObscureTextField;

  @override
  void initState() {
    super.initState();
    isObscureTextField = obscureText;
    focusNode.addListener(onFocusChange);
  }

  void onFocusChange() {
    if (!mounted) return;
    setState(() {
      focused = focusNode.hasFocus;
    });
  }

  void toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  Widget get visibilityIcon => IconButton(
        onPressed: toggle,
        icon: Icon(
          obscureText ? Icons.visibility : Icons.visibility_off,
        ),
        padding: const EdgeInsets.all(0),
      );

  Widget get errorText => Text(
        widget.error,
        style: Style.caption!.copyWith(color: Style.colors.error),
      );

  Widget textField() => Theme(
        data: ThemeData(
          fontFamily: Style.fontFamily,
          primaryColor: Style.colors.primary,
          hintColor: Style.colors.grey,
        ),
        child: Material(
          color: Colors.transparent,
          child: TextField(
            cursorColor: Style.colors.primary,
            keyboardAppearance: Style.appBrightness,
            readOnly: widget.readonly,
            autocorrect: widget.autocorrect,
            autofocus: widget.autofocus,
            controller: widget.controller,
            focusNode: focusNode,
            key: widget.key,
            keyboardType: widget.keyboardType,
            obscureText: obscureText,
            onChanged: widget.onChange,
            onTap: widget.onTap,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            decoration: InputDecoration(
              alignLabelWithHint: widget.minLines! > 1,
              labelText: widget.title ?? widget.placeholder,
              hintText: widget.placeholder,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              suffixIcon:
                  isObscureTextField ? visibilityIcon : widget.suffixIcon,
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    Column column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Style.colors.lightBackground,
            borderRadius: Style.border10,
            border: Border.all(width: borderWidth, color: borderColor),
          ),
          child: textField(),
        ),
      ],
    );

    if (widget.error.isNotEmpty) {
      column.children.addAll([
        const SizedBox(height: 4.0),
        errorText,
      ]);
    }

    return column;
  }
}
