
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../error_full_info.dart';
import 'error_resolvers.dart';
import 'resolve_result.dart';

mixin ErrorUtil {
  final List<ExceptionResolver> _exceptionResolvers = <ExceptionResolver>[];

  ResolveResult resolveByException({
    required BuildContext context,
    required Object exception,
    StackTrace? stackTrace,
  }) {
    for (final ExceptionResolver resolver in _exceptionResolvers) {
      final ResolveResult? result =
          resolver.resolveException(context, exception, stackTrace);
      if (result != null) {
        return result;
      }
    }

    return ResolveResult(
      message: LocaleKeys.error_unexpected_error_occurred.tr(),
      title: Text(LocaleKeys.error_unexpected_error_occurred.tr()),
      icon: const Icon(Icons.error_outline_rounded),
      getMore: appLocator<AppConfig>().showDebugStackTrace && stackTrace != null
          ? (BuildContext context) => ErrorFullInfo(
                title: Text(LocaleKeys.error_unexpected_error_occurred.tr()),
                stackTrace: stackTrace,
              )
          : null,
    );
  }
}
