import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity {
  final int id;
  final String name;
  final String username;
  final String email;
  final AddressEntity address;
  final String phone;
  final String website;
  final CompanyEntity company;

  const UserEntity({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) => _$UserEntityFromJson(json);
  
}

@JsonSerializable()
class AddressEntity {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final GeoEntity geo;

  const AddressEntity({required this.street, required this.suite, required this.city, required this.zipcode, required this.geo});
  factory AddressEntity.fromJson(Map<String, dynamic> json) => _$AddressEntityFromJson(json);
}

@JsonSerializable()
class GeoEntity {
  final String lat;
  final String lng;

  const GeoEntity({required this.lat, required this.lng});

  factory GeoEntity.fromJson(Map<String, dynamic> json) => _$GeoEntityFromJson(json);
}


@JsonSerializable()
class CompanyEntity {
  final String name;
  final String catchPhrase;
  final String bs;

  const CompanyEntity({required this.name, required this.catchPhrase, required this.bs});

  factory CompanyEntity.fromJson(Map<String, dynamic> json) => _$CompanyEntityFromJson(json);
}