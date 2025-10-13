import 'package:data/src/db/app_drift_db.dart';
import 'package:data/src/db/tables/user/user_table.dart';
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
  Future<void> saveAllUsers(List<UserEntity> users) async {
    await _db.batch((batch) {
      batch.deleteAll(_db.addresses);
      batch.deleteAll(_db.companies);
      batch.deleteAll(_db.users);
      batch.insertAllOnConflictUpdate(
        _db.users,
        users.map((u) => UsersCompanion.insert(
              id: Value(u.id),
              name: u.name,
              username: u.username,
              email: u.email,
              phone: u.phone,
              website: u.website,
            )),
      );
      final addresses = users.map((u) => AddressesCompanion.insert(
            userId: u.id,
            street: u.address.street,
            suite: u.address.suite,
            city: u.address.city,
            zipcode: u.address.zipcode,
            lat: u.address.geo.lat,
            lng: u.address.geo.lng,
          ));
      
      batch.insertAll(_db.addresses, addresses,);
      
      final companies = users.map((u) => CompaniesCompanion.insert(
            userId: u.id,
            name: u.company.name,
            catchPhrase: u.company.catchPhrase,
            bs: u.company.bs,
          ));

      batch.insertAll(_db.companies, companies,);
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
