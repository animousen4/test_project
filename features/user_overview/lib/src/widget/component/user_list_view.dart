import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../../bloc/user_overview_bloc.dart';
import 'user_overview_error_banner.dart';
import 'user_tile.dart';

class UserListView extends StatelessWidget {
  const UserListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserOverviewBloc, UserOverviewState>(
      builder: (BuildContext context, UserOverviewState state) {
        final List<UserModel> data = state.data ?? <UserModel>[];
        if (state.isProcessing) {
          return const CircularProgressIndicator();
        }
        if (data.isEmpty) {
          return Text(LocaleKeys.user_not_found.tr());
        }
        if (state.isFailed) {
          return UserOverviewErrorBanner(
            error: state.error,
            stackTrace: state.stackTrace,
          );
        }
        return ListView.builder(
          itemBuilder:
              (BuildContext context, int index) => UserTile(user: data[index]),
        );
      },
    );
  }
}
