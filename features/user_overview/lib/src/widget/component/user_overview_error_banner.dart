import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// {@template user_overview_error_banner}
/// UserOverviewErrorBanner widget.
/// {@endtemplate}
class UserOverviewErrorBanner extends StatelessWidget {
  /// {@macro user_overview_error_banner}
  const UserOverviewErrorBanner({
    super.key, // ignore: unused_element_parameter
    this.error,
    this.stackTrace,
  });

  final Object? error;
  final StackTrace? stackTrace;

  /// Error util?
  @override
  Widget build(BuildContext context) => RichText(
    text: TextSpan(
      text: switch (error) {
        final AppException e => e.message,
        _ => LocaleKeys.error_unexpected_error_occurred.tr(),
      },

      children:
          kDebugMode
              ? <TextSpan>[
                TextSpan(text: '\n${stackTrace ?? 'No stack trace'}'),
              ]
              : null,
    ),
  );
}
