import 'package:core/core.dart';
import 'package:data/src/providers/user_cache_provider.dart';
import 'package:domain/domain.dart';

import '../../entities/user_entity.dart';
import '../../mappers/entity_mapper.dart';
import '../../providers/user_api_provider.dart';

class UserRepositoryImpl implements UserRepository {
  final UserApiProvider _userApi;
  final UserCacheProvider _userCacheProvider;
  final ToModelMapper<UserModel, UserEntity> _userMapper;

  UserRepositoryImpl(
      {required UserApiProvider userApi,
      required UserCacheProvider userCacheProvider,
      required ToModelMapper<UserModel, UserEntity> userMapper})
      : _userApi = userApi,
        _userCacheProvider = userCacheProvider,
        _userMapper = userMapper;

  @override
  Future<List<UserModel>> fetchAllUsers() async {
    try {
      return _userApi
          .fetchAllUsers()
          .then((List<UserEntity> v) => v.map(_userMapper.mapToModel).toList());
    } on DioException catch (e) {
      final cachedUsers = await _userCacheProvider.fetchAllUsers();

      if (e.type == DioExceptionType.connectionTimeout &&
          cachedUsers.isNotEmpty) {
        return cachedUsers.map(_userMapper.mapToModel).toList();
      } else {
        rethrow;
      }
    }
  }
}
