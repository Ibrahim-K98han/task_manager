import 'package:flutter/material.dart';

void showSnackBarMessage(BuildContext context, String messge,
    [bool isError = false]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(messge),
      backgroundColor: isError ? Colors.red : null,
    ),
  );
}
