import 'package:domain/domain.dart';
import 'package:flutter/widgets.dart';

/// {@template user_address_overview}
/// UserAddressOverview widget.
/// {@endtemplate}
class UserAddressOverview extends StatelessWidget {
  /// {@macro user_address_overview}
  const UserAddressOverview({
    super.key, // ignore: unused_element_parameter
    required this.address,
  });

  final AddressModel address;

  String getAddressString() {
    return '${address.street}, ${address.suite}, ${address.city}, ${address.zipcode}';
  }

  @override
  Widget build(BuildContext context) => Text(getAddressString());
}
