import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:ibs/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDgQ5f7vx5WKKbzRGlVh7ksQijtubgu6A8",
      appId: "1:889876200583:ios:d330b85fd3b402e784cc22",
      messagingSenderId: "889876200583",
      projectId: "ibs-platform-4518a",
    ),
  );

  runApp(const IbsApp());
}
