import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../routes.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final dio = Dio();
  String _email = "";
  String _password = "";

  Future<List<dynamic>> fetchData() async {
    try {
      final response = await dio.get('http://192.168.10.234:3000/users');
      return response.data;
    } catch (e) {
      print(e);
      return [];
    }
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      //*login logic
      List<dynamic> users = await fetchData();
      for (var user in users) {
        if (user['email'] == _email && user['password'] == _password) {
          if (user['role'] == "student") {
            //navigate to show briefs
            Navigator.pushNamed(context, Routes.home);
          } else if (user['role'] == "teacher") {
            //navigate to show students and add briefs
            Navigator.pushNamed(context, Routes.dashboard);
          }
          return; // exit the function after finding a matching user
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your email address.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your password.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                child: Text('Login'),
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
