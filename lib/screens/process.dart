import 'package:flutter/material.dart';
import 'package:ibs/theme/style.dart';

class ProcessScreen extends StatelessWidget {
  const ProcessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.developer_board, color: Style.colors.black),
            const SizedBox(width: 10),
            Text("In process", style: Style.body1)
          ],
        ),
      ),
    );
  }
}
