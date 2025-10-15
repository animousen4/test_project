import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import '../component/user_address_overview.dart';

@RoutePage()
class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(
        LocaleKeys.user_user_data.tr(
          namedArgs: <String, String>{'username': user.username},
        ),
      ),
    ),
    body: ListView(
      children: <Widget>[
        ListTile(
          title: Text(LocaleKeys.user_username.tr()),
          subtitle: Text(user.username),
        ),
        ListTile(
          title: Text(LocaleKeys.user_email.tr()),
          subtitle: Text(user.email),
        ),
        ListTile(
          title: Text(LocaleKeys.user_address.tr()),
          subtitle: UserAddressOverview(address: user.address),
        ),
        ListTile(
          title: Text(LocaleKeys.user_phone.tr()),
          subtitle: Text(user.phone),
        ),
      ],
    ),
  );
}
