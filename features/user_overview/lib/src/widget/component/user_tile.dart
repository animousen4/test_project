import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import '../../../user_overview.dart';

class UserTile extends StatelessWidget {
  const UserTile({required this.user, super.key});

  final UserModel user;

  @override
  Widget build(BuildContext context) => ListTile(
    title: Text(user.username),
    onTap: () {
      context.router.push(UserDetailsRoute(user: user));
    },
  );
}
