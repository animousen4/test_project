import 'package:domain/domain.dart';

import '../entities/user_entity.dart';
import '../mappers/entity_mapper.dart';
import '../providers/user_api_provider.dart';

class UserRepositoryImpl implements UserRepository {
  final UserApiProvider _userApi;
  final ToModelMapper<UserModel, UserEntity> _userMapper;

  UserRepositoryImpl(
      {required UserApiProvider userApi,
      required ToModelMapper<UserModel, UserEntity> userMapper})
      : _userApi = userApi,
        _userMapper = userMapper;

  @override
  Future<List<UserModel>> fetchAllUsers() {
    return _userApi
        .fetchAllUsers()
        .then((List<UserEntity> v) => v.map(_userMapper.mapToModel).toList());
  }
}
