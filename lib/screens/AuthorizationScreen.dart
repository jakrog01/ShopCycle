import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AuthorizationScreen extends StatefulWidget {
  const AuthorizationScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AutohrizationScreenState();
  }
}

class _AutohrizationScreenState extends State<AuthorizationScreen> {
  var _isLogin = true;
  var _acceptTerms = false;

  Widget TermsCheckBox() {
    if (_isLogin) {
      return Container();
    } else {
      return CheckboxListTile(
          contentPadding: EdgeInsets.only(left: 5),
          controlAffinity: ListTileControlAffinity.leading,
          title: Transform.translate(
            offset: const Offset(-10, 0),
            child: Row(
              children: [
                Text(
                  "I accept the",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                InkWell(
                    child: const Text(' terms'),
                    onTap: () {
                      launchUrlString(
                          'https://media.tenor.com/o2rlJc1PoLMAAAAi/dancin-monkey.gif');
                    }),
              ],
            ),
          ),
          value: _acceptTerms,
          onChanged: (newValue) {
            setState(() {
              _acceptTerms = newValue!;
            });
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.only(
                        top: 20, bottom: 10, left: 20, right: 20),
                    width: 250,
                    child: Image.asset('assets/images/slicon.png')),
                Card(
                    margin: const EdgeInsets.all(16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        child: Form(
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                              TextFormField(
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.mail),
                                    labelText: 'Email Address'),
                                keyboardType: TextInputType.emailAddress,
                                autocorrect: false,
                                textCapitalization: TextCapitalization.none,
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.lock_rounded),
                                    labelText: 'Password'),
                                obscureText: true,
                              ),
                              TermsCheckBox(),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _isLogin = !_isLogin;
                                        });
                                      },
                                      child: Text(_isLogin
                                          ? 'Create an acconut'
                                          : "I already have an account")),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .primaryContainer),
                                      onPressed: () {},
                                      child: Text(
                                          _isLogin ? "Sign in" : "Sign up")),
                                ],
                              ),
                            ])),
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
