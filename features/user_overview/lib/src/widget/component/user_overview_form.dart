import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../../bloc/user_overview_bloc.dart';
import 'user_overview_error_banner.dart';
import 'user_tile.dart';

class UserOverviewForm extends StatefulWidget {
  const UserOverviewForm({super.key});

  @override
  State<UserOverviewForm> createState() => _UserOverviewFormState();
}

class _UserOverviewFormState extends State<UserOverviewForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          final UserOverviewState state =
              BlocProvider.of<UserOverviewBloc>(context, listen: true).state;

          final List<UserModel> users = state.data ?? <UserModel>[];

          if (state.isProcessing) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.isFailed) {
            return Center(
              child: UserOverviewErrorBanner(
                error: state.error,
                stackTrace: state.stackTrace,
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<UserOverviewBloc>().add(
                const UserOverviewEvent.load(),
              );
            },
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder:
                  (BuildContext context, int index) =>
                      UserTile(user: users[index]),
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    context.read<UserOverviewBloc>().add(const UserOverviewEvent.load());
  }
}
