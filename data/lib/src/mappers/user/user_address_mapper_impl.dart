import 'package:domain/domain.dart';

import '../../entities/user_entity.dart';
import '../entity_mapper.dart';

class UserAddressMapperImpl
    implements ToModelMapper<AddressModel, AddressEntity> {
  const UserAddressMapperImpl(
      {required ToModelMapper<GeoModel, GeoEntity> geoMapper,})
      : _geoMapper = geoMapper;

  final ToModelMapper<GeoModel, GeoEntity> _geoMapper;

  @override
  AddressModel mapToModel(AddressEntity entity) {
    return AddressModel(
      street: entity.street,
      suite: entity.suite,
      city: entity.city,
      zipcode: entity.zipcode,
      geo: _geoMapper.mapToModel(entity.geo),
    );
  }
}
