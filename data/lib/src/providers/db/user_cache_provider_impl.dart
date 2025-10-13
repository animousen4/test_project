import 'package:data/src/db/app_drift_db.dart';
import 'package:data/src/entities/user_entity.dart';
import 'package:data/src/providers/user_cache_provider.dart';
import 'package:drift/drift.dart';

class UserCacheProviderImpl implements UserCacheProvider {
  final AppDriftDatabase _db;
  final UserDbModelMapper _userDbModelMapper;
  const UserCacheProviderImpl(
      {required UserDbModelMapper userDbModelMapper,
      required AppDriftDatabase db})
      : _db = db,
        _userDbModelMapper = userDbModelMapper;

  @override
  Future<List<UserEntity>> fetchAllUsers() {
    return _db
        .select(_db.users)
        .join([
          innerJoin(
              _db.addresses, _db.addresses.userId.equalsExp(_db.users.id)),
          innerJoin(
              _db.companies, _db.companies.userId.equalsExp(_db.users.id)),
        ])
        .map(
          (e) => _userDbModelMapper.mapToEntity(
            user: e.readTable(_db.users),
            address: e.readTable(_db.addresses),
            company: e.readTable(_db.companies),
          ),
        )
        .get();
  }

  @override
  Future<void> saveAllUsers(List<UserEntity> users) {
    return _db.transaction(() async {
      for (final user in users) {
        await _db.into(_db.users).insertOnConflictUpdate(
              UsersCompanion.insert(
                id: user.id,
                name: user.name,
                username: user.username,
                email: user.email,
                phone: user.phone,
                website: user.website,
              ),
            );

        await _db.into(_db.addresses).insertOnConflictUpdate(
              AddressesCompanion.insert(
                userId: user.id,
                street: user.address.street,
                suite: user.address.suite,
                city: user.address.city,
                zipcode: user.address.zipcode,
                lat: user.address.geo.lat,
                lng: user.address.geo.lng,
              ),
            );

        await _db.into(_db.companies).insertOnConflictUpdate(
              CompaniesCompanion.insert(
                userId: user.id,
                name: user.company.name,
                catchPhrase: user.company.catchPhrase,
                bs: user.company.bs,
              ),
            );
      }
    });
  }
}

class UserDbModelMapper {
  UserEntity mapToEntity(
      {required User user,
      required Address address,
      required Company company}) {
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
