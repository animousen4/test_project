import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'util/resolve_result.dart';

class DefaultErrorForm extends StatelessWidget {
  const DefaultErrorForm({
    this.result,
    this.errorContextTitle,
    this.onRetry,
    super.key,
  });

  final ResolveResult? result;
  final Widget? errorContextTitle;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final Widget Function(BuildContext)? getMore = result?.getMore;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        result?.icon ??
            Icon(
              Icons.warning_rounded,
              color: Theme.of(context).colorScheme.error,
            ),
        const SizedBox(
          height: 10,
        ),
        if (errorContextTitle != null) ...<Widget>[
          DefaultTextStyle.merge(
            style: const TextStyle(fontWeight: FontWeight.bold),
            child: errorContextTitle!,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
        result?.title ??
            Text(
              LocaleKeys.error_unexpected_error_occurred.tr(),
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
        if (getMore != null)
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: getMore,
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
            icon: const Icon(Icons.refresh),
          ),
      ],
    );
  }
}
