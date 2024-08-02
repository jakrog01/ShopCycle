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
  final _form = GlobalKey<FormState>();

  var _isLogin = true;
  var _acceptTerms = false;
  var _enteredEmail = '';
  var _enteredPassword = '';

  void _submit() {
    final formsValidation = _form.currentState!.validate();
    var termsValidation = false;

    if (!_isLogin && _acceptTerms) {
      termsValidation = true;
    }

    if (formsValidation && termsValidation) {
      _form.currentState!.save();
      print(_enteredEmail);
      print(_enteredPassword);
    }
  }

  bool specialSignsValidator(String value) {
    RegExp regex = RegExp(r'[!@#\$&*~]');
    if (!regex.hasMatch(value)) {
      return true;
    }
    return false;
  }

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
                            key: _form,
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
                                validator: (value) {
                                  if (value == null ||
                                      value.trim().isEmpty ||
                                      !value.contains('@') ||
                                      !value.contains('.') ||
                                      value.length < 6){
                                    return 'Please enter a valid email address';
                                  }
                                  return null;
                                },
                                onSaved: (newValue) {
                                  _enteredEmail = newValue!;
                                },
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.lock_rounded),
                                    labelText: 'Password'),
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Please enter a password";
                                  } else if (value.trim().length < 6) {
                                    return "Password too short, min 6 characters";
                                  } else if (value.trim().length > 25) {
                                    return "Password too long, max 25 characters";
                                  } else if (specialSignsValidator(value)) {
                                    return "The password must have one special character";
                                  }
                                  return null;
                                },
                                onSaved: (newValue) {
                                  _enteredPassword = newValue!;
                                },
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
                                      onPressed: _submit,
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
