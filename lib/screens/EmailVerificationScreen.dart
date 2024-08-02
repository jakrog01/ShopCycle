import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _EmailVerificationScreenState();
  }
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  Timer? timer;

  @override
  void initState() {
    timer =
        Timer.periodic(const Duration(seconds: 1), (_) => checkEmailVerified());
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  checkEmailVerified() {
    FirebaseAuth.instance.currentUser?.reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Waiting for email verification",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Your email adress: ${FirebaseAuth.instance.currentUser!.email}",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Verify your email",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.currentUser!.delete();
                    FirebaseAuth.instance.signOut();
                  },
                  child: const Text("Cancel")),
            ],
          ),
        ));
  }
}
