import 'package:domain/domain.dart';

import '../../entities/user_entity.dart';
import '../entity_mapper.dart';

class UserModelMapper implements ToModelMapper<UserModel, UserEntity> {
  const UserModelMapper({
    required ToModelMapper<AddressModel, AddressEntity> addressMapper,
    required ToModelMapper<CompanyModel, CompanyEntity> companyMapper,
  })  : _addressMapper = addressMapper,
        _companyMapper = companyMapper;

  final ToModelMapper<AddressModel, AddressEntity> _addressMapper;
  final ToModelMapper<CompanyModel, CompanyEntity> _companyMapper;

  @override
  UserModel mapToModel(UserEntity entity) {
    return UserModel(
      id: entity.id,
      username: entity.username,
      address: _addressMapper.mapToModel(entity.address),
      phone: entity.phone,
      website: entity.website,
      company: _companyMapper.mapToModel(entity.company),
      name: entity.name,
      email: entity.email,
    );
  }
}
