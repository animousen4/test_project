part of 'user_model.dart';

class AddressModel {

  AddressModel(
      {required this.street,
      required this.suite,
      required this.city,
      required this.zipcode,
      required this.geo,});
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final GeoModel geo;
}
