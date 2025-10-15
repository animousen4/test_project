import '../../db/app_drift_db.dart';
import '../../entities/user_entity.dart';
import 'user_db_model_mapper.dart';

class UserDbModelMapperImpl implements UserDbModelMapper {
  @override
  UserEntity mapToEntity({
    required User user,
    required Address address,
    required Company company,
  }) {
    return UserEntity(
      id: user.id,
      name: user.name,
      username: user.username,
      email: user.email,
      phone: user.phone,
      website: user.website,
      address: AddressEntity(
        street: address.street,
        suite: address.suite,
        city: address.city,
        zipcode: address.zipcode,
        geo: GeoEntity(
          lat: address.lat,
          lng: address.lng,
        ),
      ),
      company: CompanyEntity(
        name: company.name,
        catchPhrase: company.catchPhrase,
        bs: company.bs,
      ),
    );
  }
}
