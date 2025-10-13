import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
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
      return ErrorBanner(exception: state.error!);
    }

    return ListView.builder(
      itemCount: users.length,
      itemBuilder:
          (BuildContext context, int index) => _UserTile(user: users[index]),
    );
  }
}

/// {@template user_overview_screen}
/// _UserTile widget.
/// {@endtemplate}
class _UserTile extends StatelessWidget {
  /// {@macro user_overview_screen}
  const _UserTile({
    required this.user,
    super.key, // ignore: unused_element_parameter
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) => ListTile(title: Text(user.name));
}
