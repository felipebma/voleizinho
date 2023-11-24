import 'package:flutter/material.dart';

class ErrorSnackbar extends SnackBar {
  ErrorSnackbar({
    Key? key,
    required String content,
  }) : super(
          key: key,
          backgroundColor: Colors.red[700],
          content: Text(
            content,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        );
}
