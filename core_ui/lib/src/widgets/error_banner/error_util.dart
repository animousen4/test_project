import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'error_full_info.dart';

/// {@template error_util}
/// ErrorUtilScope widget.
/// {@endtemplate}
class ErrorUtilScope extends StatefulWidget {
  /// {@macro error_util}
  const ErrorUtilScope({
    required this.child,
    super.key, // ignore: unused_element
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  static ErrorUtil? maybeOf(BuildContext context) => context
      .getInheritedWidgetOfExactType<_ErrorUtilScopeInherited>()
      ?.errorUtil;

  @override
  State<ErrorUtilScope> createState() => _ErrorUtilScopeState();
}

/// {@template error_util}
/// _ErrorUtilScopeInherited widget.
/// {@endtemplate}
class _ErrorUtilScopeInherited extends InheritedWidget {
  /// {@macro error_util}
  const _ErrorUtilScopeInherited({
    required super.child,
    required this.errorUtil,
    super.key, // ignore: unused_element_parameter
  });

  final ErrorUtil errorUtil;
  @override
  bool updateShouldNotify(covariant _ErrorUtilScopeInherited oldWidget) =>
      false;
}

/// State for widget ErrorUtilScope.
class _ErrorUtilScopeState extends State<ErrorUtilScope> with ErrorUtil {
  @override
  Widget build(BuildContext context) => _ErrorUtilScopeInherited(
        errorUtil: this,
        child: widget.child,
      );
}

mixin ErrorUtil {
  final List<ExceptionResolver> _exceptionResolvers = <ExceptionResolver>[];

  ResolveResult resolveByException(
    BuildContext context,
    Object exception, [
    StackTrace? stackTrace,
  ]) {
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

class ResolveResult {
  ResolveResult({
    required this.message,
    required this.title,
    required this.icon,
    required this.getMore,
  });
  final String? message;
  final Widget title;
  final Widget? icon;
  final Widget Function(BuildContext)? getMore;
}

abstract class ExceptionResolver {
  ResolveResult? resolveException(
    BuildContext context,
    Object exception, [
    StackTrace? stackTrace,
  ]);
}

class ExceptionResolver$DioException implements ExceptionResolver {
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
