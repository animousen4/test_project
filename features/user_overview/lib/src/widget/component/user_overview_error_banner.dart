import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/widgets.dart';

import '../../bloc/user_overview_bloc.dart';

class UserOverviewErrorBanner extends StatelessWidget {
  const UserOverviewErrorBanner({super.key, this.error, this.stackTrace});

  final Object? error;
  final StackTrace? stackTrace;

  @override
  Widget build(BuildContext context) => DefaultErrorBanner(
    exception: error,
    stackTrace: stackTrace,
    onRetry: () {
      context.read<UserOverviewBloc>().add(const UserOverviewEvent.load());
    },
  );
}
