import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.title});
  final String title;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String username = '';
  String password = '';
  String verifyPassword = '';
  bool isPasswordVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 300,
              child: TextField(
                decoration: InputDecoration(labelText: 'Username'),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (isPasswordVisible) {
                        setState(() {
                          isPasswordVisible = false;
                        });
                      } else {
                        setState(() {
                          isPasswordVisible = true;
                        });
                      }
                    },
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
                obscureText: isPasswordVisible,
              ),
            ),

            SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: TextField(
                decoration: InputDecoration(labelText: 'Verify Password'),
                obscureText: isPasswordVisible,
              ),
            ),
            SizedBox(height: 20),
            OutlinedButton(onPressed: () {}, child: Text('Register')),
          ],
        ),
      ),
    );
  }
}
