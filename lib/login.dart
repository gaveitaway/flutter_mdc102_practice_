// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Image.asset('assets/diamond.png'),
                const SizedBox(height: 16.0),
                const Text('SHRINE'),
              ],
            ),
            const SizedBox(height: 120.0),
            // TODO: Wrap Username with AccentColorOverride (103)
            // TODO: Remove filled: true values (103)
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 12.0),
            // TODO: Wrap Password with AccentColorOverride (103)
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            ButtonBar(
              children: <Widget>[
                // TODO: Add a beveled rectangular border to CANCEL (103)
                TextButton(
                  child: const Text('CANCEL'),
                  onPressed: () {
                    _usernameController.clear();
                    _passwordController.clear();
                  },
                ),
                TextButton(
                  child: const Text('Sign up'),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return SignPage();
                    }));
                  },
                ),
                // TODO: Add an elevation to NEXT (103)
                // TODO: Add a beveled rectangular border to NEXT (103)
                ElevatedButton(
                  child: const Text('NEXT'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/second');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// TODO: Add AccentColorOverride (103)
class SignPage extends StatefulWidget {
   SignPage({Key? key}) : super(key: key);

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  final _usernameController = TextEditingController();

  final _passwordnewController = TextEditingController();

   final ConfirmnewController = TextEditingController();

   final EmailCOntroller = TextEditingController();

   final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Form(
      key: _formKey,
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            children: <Widget>[

              const SizedBox(height: 40.0),
              // TODO: Wrap Username with AccentColorOverride (103)
              // TODO: Remove filled: true values (103)
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Username',
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username is invalid';
                  }

                },

              ),
              new FlutterPwValidator(
                controller: _usernameController,
                minLength: 0,
                uppercaseCharCount: 0,
                numericCharCount: 3,
                specialCharCount: 0,
                normalCharCount: 3,
                width: 400,
                height: 150,
                onSuccess: () {
                  return null;
                },
                onFail: () {
                  if(_usernameController.value == null) {
                    return 'ENter a valid username';
                  }
                  },
              ),
              const SizedBox(height: 12.0),
              // TODO: Wrap Password with AccentColorOverride (103)
              TextFormField(
                controller: _passwordnewController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Password',

                ),

                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is invalid';
                  }
                  return null;
                },




              ),

              const SizedBox(height: 12.0),
              TextFormField(
                controller: ConfirmnewController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Comfirm Password',

                ),
                obscureText: true,
                validator: (value3) {
                  if ((_passwordnewController.value != ConfirmnewController.value)||(value3 == null || value3.isEmpty) ) {

                    return 'Confirm Password doesn  t match Password';

                  }

                  return null;
                },
              ),
              const SizedBox(height: 12.0),
              TextFormField(
                controller: EmailCOntroller,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Email Address',

                ),
                  validator: (value) {
                  if (value == null || value.isEmpty) {
                  return 'Please enter email address';
                  }
                  return null;
                  },
              ),
              ButtonBar(
                children: <Widget>[
                  // TODO: Add a beveled rectangular border to CANCEL (103)

                  ElevatedButton(
                    child: const Text('Sign in up'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) {
                          return LoginPage();
                        }));
                      }


                      }

                  ),
                  // TODO: Add an elevation to NEXT (103)
                  // TODO: Add a beveled rectangular border to NEXT (103)

                ],
              ),
            ],
          ),
    ),
      )
    );
  }
}




