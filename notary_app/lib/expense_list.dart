import 'package:flutter/material.dart';

class ExpensesListScreen extends StatelessWidget {
  final Map<String, dynamic> response;

  ExpensesListScreen({required this.response});

  @override
  Widget build(BuildContext context) {
    final expenseList = response['expenseList'] as List<dynamic>;

    return Scaffold(
      appBar: AppBar(title: Text('Expenses List')),
      body: ListView.builder(
        itemCount: expenseList.length,
        itemBuilder: (context, index) {
          final expense = expenseList[index];
          final companyName = expense['companyName'] as String;
          final expenseName = expense['expenseName'] as String;

          return ListTile(
            title: Text(companyName),
            subtitle: Text(expenseName),
          );
        },
      ),
    );
  }
}
