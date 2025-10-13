import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) => BlocProvider<UserOverviewBloc>(
    create:
        (BuildContext context) => UserOverviewBloc(
          fetchAllUsersUseCase: appLocator<FetchUsersUseCase>(),
        ),
    child: const _Body(),
  );
}

/// {@template user_overview_screen}
/// _Body widget.
/// {@endtemplate}
class _Body extends StatelessWidget {
  /// {@macro user_overview_screen}
  const _Body({
    super.key, // ignore: unused_element_parameter
  });

  @override
  Widget build(BuildContext context) {
    final UserOverviewState state =
        BlocProvider.of<UserOverviewBloc>(context).state;

    final List<UserModel> users = state.data ?? <UserModel>[];

    if (state.isProcessing) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return Center(child: Text(state.error.toString()));
    }

    return ListView.builder(
      itemCount: users.length,
      itemBuilder:
          (BuildContext context, int index) =>
              ListTile(title: Text(users[index].name)),
    );
  }
}
