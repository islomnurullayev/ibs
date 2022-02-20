import 'package:flutter/cupertino.dart';
import 'package:ibs/blocs/auth/login.dart';
import 'package:ibs/cells/button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileController extends StatelessWidget {
  const ProfileController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Button.primary(
          text: "Log out",
          onPressed: () {
            context.read<LoginCubit>().signOut();
          }),
    );
  }
}
