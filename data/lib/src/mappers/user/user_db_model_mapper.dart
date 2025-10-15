import '../../db/app_drift_db.dart';
import '../../entities/user_entity.dart';

abstract interface class UserDbModelMapper {
  UserEntity mapToEntity({
    required User user,
    required Address address,
    required Company company,
  });
}
