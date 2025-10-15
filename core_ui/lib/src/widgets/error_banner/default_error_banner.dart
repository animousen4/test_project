import 'package:flutter/material.dart';

import 'default_error_form.dart';
import 'error_util_scope.dart';
import 'util/resolve_result.dart';

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
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final ResolveResult? result = exception != null
        ? ErrorUtilScope.maybeOf(context)?.resolveByException(
            context: context,
            exception: exception!,
            stackTrace: stackTrace,
          )
        : null;

    return DefaultErrorForm(
      result: result,
      errorContextTitle: errorContextTitle,
      onRetry: onRetry,
    );
  }
}
