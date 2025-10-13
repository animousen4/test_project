import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'error_util.dart';

class ErrorBanner extends StatelessWidget {
  const ErrorBanner(
      {super.key,
      required this.exception,
      this.errorContextTitle,
      this.onRetry});

  final Widget? errorContextTitle;

  final Object exception;

  final void Function()? onRetry;

  @override
  Widget build(BuildContext context) {
    final result =
        ErrorUtilScope.maybeOf(context)?.resolveByException(context, exception);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        result?.icon ??
            Icon(
              Icons.warning,
              color: Theme.of(context).colorScheme.error,
            ),
        const SizedBox(
          height: 10,
        ),
        if (errorContextTitle != null) ...[
          DefaultTextStyle.merge(
              style: const TextStyle(fontWeight: FontWeight.bold),
              child: errorContextTitle!),
          const SizedBox(
            height: 10,
          ),
        ],
        result?.title ??
            Text(
              LocaleKeys.error_unexpected_error_occurred.tr(),
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
        if (result?.getMore != null)
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => result!.getMore!(context),
              );
            },
            child: Text(LocaleKeys.error_show_exception_details.tr()),
          ),
        const SizedBox(
          height: 10,
        ),
        if (onRetry != null)
          TextButton.icon(
              onPressed: onRetry,
              label: Text(LocaleKeys.common_retry.tr()),
              icon: const Icon(Icons.refresh)),
      ],
    );
  }
}
