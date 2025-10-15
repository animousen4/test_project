import 'dart:io';

import 'package:core/core.dart';
import 'package:domain/domain.dart';

import '../../entities/user_entity.dart';
import '../../mappers/entity_mapper.dart';
import '../../providers/user_api_provider.dart';
import '../../providers/user_cache_provider.dart';

class UserRepositoryImpl implements UserRepository {

  UserRepositoryImpl(
      {required UserApiProvider userApi,
      required UserCacheProvider userCacheProvider,
      required ToModelMapper<UserModel, UserEntity> userMapper,})
      : _userApi = userApi,
        _userCacheProvider = userCacheProvider,
        _userMapper = userMapper;
  final UserApiProvider _userApi;
  final UserCacheProvider _userCacheProvider;
  final ToModelMapper<UserModel, UserEntity> _userMapper;

  @override
  Future<List<UserModel>> fetchAllUsers() async {
    try {
      final List<UserEntity> users = await _userApi.fetchAllUsers();

      await _userCacheProvider.saveAllUsers(users);

      return users.map(_userMapper.mapToModel).toList();
    } on SocketException catch (_) {
      final List<UserModel> cachedUsers = await getCachedUsers();

      if (cachedUsers.isEmpty) {
        rethrow;
      }

      return cachedUsers;
    } on DioException catch (e) {
      final List<UserModel> cachedUsers = await getCachedUsers();
      if (e.type == DioExceptionType.connectionError &&
          cachedUsers.isNotEmpty) {
        return cachedUsers;
      }
      rethrow;
    }
  }

  Future<List<UserModel>> getCachedUsers() {
    return _userCacheProvider
        .fetchAllUsers()
        .then((List<UserEntity> v) => v.map(_userMapper.mapToModel).toList());
  }
}
