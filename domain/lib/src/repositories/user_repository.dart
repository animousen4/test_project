import '../../domain.dart';

abstract interface class UserRepository {
  Future<List<UserModel>> fetchAllUsers();
}
