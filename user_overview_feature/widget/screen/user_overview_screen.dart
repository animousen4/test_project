import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/widgets.dart';

import '../../bloc/user_overview_bloc.dart';

/// {@template user_overview_screen}
/// UserOverviewScreen widget.
/// {@endtemplate}
class UserOverviewScreen extends StatelessWidget {
  /// {@macro user_overview_screen}
  const UserOverviewScreen({
    super.key, // ignore: unused_element_parameter
  });

  @override
  Widget build(BuildContext context) =>
      BlocProvider<UserOverviewBloc>(
        create:
            (BuildContext context) => UserOverviewBloc(
              fetchAllUsersUseCase: appLocator<FetchUsersUseCase>(),
            ),
        child: const Placeholder(),
      );
}


