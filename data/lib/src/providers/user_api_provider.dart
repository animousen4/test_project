import '../../data.dart';

import '../entities/user_entity.dart';

abstract class UserApiProvider extends ApiProvider {
  const UserApiProvider(super.dio);

  Future<List<UserEntity>> fetchAllUsers();
}
