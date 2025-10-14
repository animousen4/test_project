import 'package:core/core.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../entities/user_entity.dart';

part 'user_api_provider.g.dart';

@RestApi()
abstract class UserApiProvider {
  factory UserApiProvider(Dio dio,
      {String? baseUrl, ParseErrorLogger? errorLogger}) = _UserApiProvider;

  @GET('/users')
  Future<List<UserEntity>> fetchAllUsers();
}
