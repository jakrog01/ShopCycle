import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopcycle/screens/email_verification_screen.dart';
import 'package:shopcycle/screens/lists_tab_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/authorization_screen.dart';
import 'package:shopcycle/screens/loading_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

var kAppTheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 129, 129, 168),
    brightness: Brightness.dark);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData().copyWith(colorScheme: kAppTheme),
        title: "Shop Cycle",
        home: StreamBuilder(
            stream: FirebaseAuth.instance.userChanges(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingScreen();
              } else if (snapshot.hasData && !snapshot.data!.emailVerified) {
                return const EmailVerificationScreen();
              } else if (snapshot.hasData && snapshot.data!.emailVerified) {
                return const ListsTabScreen();
              }
              return const AuthorizationScreen();
            }));
  }
}
