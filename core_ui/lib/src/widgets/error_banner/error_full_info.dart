import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'stack_trace_view.dart';

class ErrorFullInfo extends StatelessWidget {
  const ErrorFullInfo({
    super.key,
    required this.title,
    this.body,
    this.stackTrace,
  });

  final Widget title;
  final Widget? body;
  final StackTrace? stackTrace;

  @override
  Widget build(BuildContext context) {
    assert(
      body != null || stackTrace != null,
      'Either body or stackTrace must be provided',
    );
    final Size size = MediaQuery.of(context).size * 0.6;
    return AlertDialog(
      title: title,
      content: SizedBox.fromSize(
        size: size,
        child: Row(
          children: <Widget>[
            if (body case final Widget nonNullBody)
              Flexible(child: nonNullBody),
            if ((appLocator<AppConfig>().showDebugStackTrace, stackTrace)
                case (
                  true,
                  final StackTrace nonNullStackTrace,
                )) ...<Widget>[
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: StackTraceView(
                    stackTrace: nonNullStackTrace,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
