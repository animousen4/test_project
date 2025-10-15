import 'package:flutter/material.dart';

import 'default_error_form.dart';
import 'error_util.dart';

class DefaultErrorBanner extends StatelessWidget {
  const DefaultErrorBanner({
    super.key,
    required this.exception,
    this.stackTrace,
    this.errorContextTitle,
    this.onRetry,
  });

  final Widget? errorContextTitle;

  final Object? exception;

  final StackTrace? stackTrace;

  final void Function()? onRetry;

  @override
  Widget build(BuildContext context) {
    final ResolveResult? result = exception != null
        ? ErrorUtilScope.maybeOf(context)
            ?.resolveByException(context, exception!, stackTrace)
        : null;

    return DefaultErrorForm(
      result: result,
      errorContextTitle: errorContextTitle,
      onRetry: onRetry,
    );
  }
}
