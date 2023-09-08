import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'expense_list.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  Future<void> login() async {
    final email = emailController.text;
    final apiUrl = 'https://staging.thenotary.app/doLogin';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print(response.body);
        Get.to(() => ExpensesListScreen(response: jsonResponse));
      } else {
        if (kDebugMode) {
          print('API Error: ${response.statusCode}');
        }
        Get.snackbar('Error', 'API Error: ${response.statusCode}');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error: $error');
      }
      Get.snackbar('Error', 'An error occurred while making the API call.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
