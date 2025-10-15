import '../../domain.dart';

class FetchUsersUseCase implements FutureUseCase<void, List<UserModel>> {

  FetchUsersUseCase({required this.userRepository});
  final UserRepository userRepository;

  @override
  Future<List<UserModel>> execute([void input]) {
    return userRepository.fetchAllUsers();
  }
}
