import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            'Saksham Suraksha',
          ),
        ),
      ),
      body: Container(
        height: 20,
        width: 10,
        color: Colors.lightBlueAccent,
      ),
    );
  }
}
