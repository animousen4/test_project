import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import '../../bloc/user_overview_bloc.dart';
import '../component/user_overview_form.dart';

@RoutePage()
class UserOverviewScreen extends StatelessWidget {
  const UserOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<UserOverviewBloc>(
    create:
        (BuildContext context) => UserOverviewBloc(
          fetchAllUsersUseCase: appLocator<FetchUsersUseCase>(),
        ),
    child: const UserOverviewForm(),
  );
}
