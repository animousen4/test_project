import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../../bloc/user_overview_bloc.dart';
import 'user_overview_error_banner.dart';

/// {@template user_list_view}
/// UserListView widget.
/// {@endtemplate}
class UserListView extends StatelessWidget {
  /// {@macro user_list_view}
  const UserListView({
    super.key, // ignore: unused_element_parameter
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserOverviewBloc, UserOverviewState>(
      builder: (BuildContext context, UserOverviewState state) {
        final List<UserModel> data = state.data ?? <UserModel>[];
        if (state.isProcessing) {
          return const CircularProgressIndicator();
        }
        if (data.isEmpty) {
          return const Text('No users found');
        }
        if (state.isFailed) {
          return UserOverviewErrorBanner(
            error: state.error,
            stackTrace: state.stackTrace,
          );
        }
        return ListView.builder(
          itemBuilder:
              (BuildContext context, int index) => _UserTile(user: data[index]),
        );
      },
    );
  }
}

/// {@template user_list_view}
/// _UserTile widget.
/// {@endtemplate}
class _UserTile extends StatelessWidget {
  /// {@macro user_list_view}
  const _UserTile({
    super.key, // ignore: unused_element_parameter
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) =>
      ListTile(title: Text(user.username), subtitle: Text(user.email));
}
