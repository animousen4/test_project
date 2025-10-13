import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import '../../bloc/user_overview_bloc.dart';
import '../../navigation/user_overview_feature_routes.dart';

/// {@template user_overview_screen}
/// UserOverviewScreen widget.
/// {@endtemplate}
@RoutePage()
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
    child: const _Screen(),
  );
}

/// {@template user_overview_screen}
/// _Body widget.
/// {@endtemplate}
class _Screen extends StatefulWidget {
  /// {@macro user_overview_screen}
  const _Screen({
    super.key, // ignore: unused_element_parameter
  });

  @override
  State<_Screen> createState() => _ScreenState();
}

class _ScreenState extends State<_Screen> {
  @override
  Widget build(BuildContext context) => const Scaffold(body: _Body());

  @override
  void initState() {
    super.initState();

    context.read<UserOverviewBloc>().add(const UserOverviewEvent.load());
  }
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
        BlocProvider.of<UserOverviewBloc>(context, listen: true).state;

    final List<UserModel> users = state.data ?? <UserModel>[];

    if (state.isProcessing) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return Center(
        child: ErrorBanner(
          exception: state.error!,
          onRetry: () {
            context.read<UserOverviewBloc>().add(
              const UserOverviewEvent.load(),
            );
          },
        ),
      );
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
  Widget build(BuildContext context) => ListTile(
    title: Text(user.name),
    onTap: () {
      context.router.push(UserDetailsRoute(user: user));
    },
  );
}
