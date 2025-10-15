import 'package:flutter/material.dart';
import 'util/error_util.dart';

class ErrorUtilScope extends StatefulWidget {
  const ErrorUtilScope({
    required this.child,
    super.key,
  });

  final Widget child;

  static ErrorUtil? maybeOf(BuildContext context) => context
      .getInheritedWidgetOfExactType<_ErrorUtilScopeInherited>()
      ?.errorUtil;

  @override
  State<ErrorUtilScope> createState() => _ErrorUtilScopeState();
}

class _ErrorUtilScopeInherited extends InheritedWidget {
  const _ErrorUtilScopeInherited({
    required super.child,
    required this.errorUtil,
  });

  final ErrorUtil errorUtil;
  
  @override
  bool updateShouldNotify(covariant _ErrorUtilScopeInherited oldWidget) =>
      false;
}

class _ErrorUtilScopeState extends State<ErrorUtilScope> with ErrorUtil {
  @override
  Widget build(BuildContext context) => _ErrorUtilScopeInherited(
        errorUtil: this,
        child: widget.child,
      );
}
