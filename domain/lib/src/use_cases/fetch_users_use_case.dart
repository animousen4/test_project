import '../../domain.dart';

class FetchUsersUseCase implements FutureUseCase<void, List<UserModel>> {
  final UserRepository userRepository;

  FetchUsersUseCase({required this.userRepository});

  @override
  Future<List<UserModel>> execute([void input]) {
    return userRepository.fetchAllUsers();
  }
}
