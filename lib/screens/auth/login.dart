import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibs/blocs/auth/login.dart';
import 'package:ibs/cells/button.dart';
import 'package:ibs/services/text_field_controller.dart';
import 'package:ibs/services/tracking_text_input.dart';
import 'package:ibs/theme/style.dart';

class LoginController extends StatefulWidget {
  const LoginController({Key? key}) : super(key: key);

  @override
  _LoginControllerState createState() => _LoginControllerState();
}

class _LoginControllerState extends State<LoginController> {
  late CheckEmail checkEmail;
  late TapGestureRecognizer signUpLinkTapRecognizer;
  LoginCubit userRepository = LoginCubit();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  initState() {
    checkEmail = CheckEmail();
    signUpLinkTapRecognizer = TapGestureRecognizer()..onTap = openSignUp;
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    signUpLinkTapRecognizer.dispose();
    super.dispose();
  }

  void openSignUp() {}

  Widget get bearFlare => Container(
        height: 200,
        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
        child: FlareActor(
          "assets/animation/Teddy.flr",
          shouldClip: false,
          alignment: Alignment.bottomCenter,
          fit: BoxFit.contain,
          controller: checkEmail,
        ),
      );

  Widget get emailField => TrackingTextInput(
        label: "Elektron pochta",
        hint: "Elektron pochtangiz qanday?",
        controller: emailController,
        onCaretMoved: (Offset? caret) {
          checkEmail.coverEyes(caret == null);
          checkEmail.lookAt(caret);
        },
      );

  Widget get passwordField => TrackingTextInput(
        label: "Parol",
        hint: "Men qarayotganim yo'q🙈",
        controller: passwordController,
        isObscured: true,
        onCaretMoved: (Offset? caret) {
          checkEmail.coverEyes(caret != null);
          checkEmail.lookAt(null);
        },
        onTextChanged: (String value) {
          checkEmail.setPassword(value);
        },
      );

  Widget get loginButton => BlocBuilder<LoginCubit, LoginState>(
        builder: (_, state) {
          return Button.primary(
            spinner: state.fetching,
            child: const Text("Kirish"),
            onPressed: () async {
              checkEmail.submitPassword();
              checkEmail.coverEyes(false);
              await context.read<LoginCubit>().login(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );
            },
          );
        },
      );

  Widget get registerLink => RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: "Profilingiz mavjudmi?  ",
          style: Style.body2,
          children: <TextSpan>[
            TextSpan(
              text: "Ro'yxatdan o'tish",
              style: Style.body2.copyWith(
                color: Style.colors.blue,
                decoration: TextDecoration.underline,
              ),
              recognizer: signUpLinkTapRecognizer,
            ),
          ],
        ),
      );

  Widget get form => Material(
        color: Style.colors.transparent,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(25.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  emailField,
                  passwordField,
                  loginButton,
                  const SizedBox(height: 25),
                  registerLink,
                ],
              ),
            ),
          ),
        ),
      );

  Widget get view => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: const [0.0, 1.0],
            colors: [
              Style.colors.primary,
              Style.colors.primary.withOpacity(0.3),
            ],
          ),
        ),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 80),
          children: [bearFlare, form],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Style.colors.white,
      child: view,
    );
  }
}
