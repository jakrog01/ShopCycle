import 'package:flutter/material.dart';
import 'screens/AuthorizationScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

var kAppTheme = ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 26, 38, 63), brightness: Brightness.dark); 

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
      colorScheme: kAppTheme
      ),
      title: "Shop Cycle",
      home: const AuthorizationScreen(),
        );
  }
}
