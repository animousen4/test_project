import '../entities/user_entity.dart';

abstract interface class UserCacheProvider {
  /// Or use UserModel
  Future<void> saveAllUsers(List<UserEntity> users);
  Future<List<UserEntity>> fetchAllUsers();
}
