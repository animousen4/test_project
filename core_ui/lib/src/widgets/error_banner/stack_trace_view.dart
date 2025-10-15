import 'package:flutter/material.dart';

class StackTraceView extends StatelessWidget {
  const StackTraceView({super.key, required this.stackTrace});

  final StackTrace stackTrace;

  @override
  Widget build(BuildContext context) {
    return Text(stackTrace.toString());
  }
}
