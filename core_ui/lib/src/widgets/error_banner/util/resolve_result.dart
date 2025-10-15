
import 'package:flutter/widgets.dart';

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
