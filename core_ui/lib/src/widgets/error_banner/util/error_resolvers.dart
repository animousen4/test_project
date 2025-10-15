
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'resolve_result.dart';

abstract class ExceptionResolver {
  ResolveResult? resolveException(
    BuildContext context,
    Object exception, [
    StackTrace? stackTrace,
  ]);
}

class ExceptionResolverDioException implements ExceptionResolver {
  @override
  ResolveResult? resolveException(
    BuildContext context,
    Object exception, [
    StackTrace? stackTrace,
  ]) {
    if (exception
        case DioException(
          type: DioExceptionType.connectionError ||
              DioExceptionType.connectionTimeout
        )) {
      return ResolveResult(
        message: 'Network error occurred',
        title: Text(LocaleKeys.error_network_error_occurred.tr()),
        icon: const Icon(Icons.warning_rounded),
        getMore: null,
      );
    }

    return null;
  }
}
