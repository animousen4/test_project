import 'dart:io';

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
      final users = await _userApi.fetchAllUsers();

      await _userCacheProvider.saveAllUsers(users);

      return users.map((e) => _userMapper.mapToModel(e)).toList();
    } on SocketException catch (_) {
      final cachedUsers = await getCachedUsers();

      if (cachedUsers.isEmpty) {
        rethrow;
      }

      return cachedUsers;
    } on DioException catch (e) {
      final cachedUsers = await getCachedUsers();
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
        .then((v) => v.map((e) => _userMapper.mapToModel(e)).toList());
  }
}
