import 'package:drift/drift.dart';

import 'user_table.dart';

@DataClassName('Address')
class Addresses extends Table {
  IntColumn get userId => integer().unique().references(Users, #id)();
  TextColumn get street => text()();
  TextColumn get suite => text()();
  TextColumn get city => text()();
  TextColumn get zipcode => text()();
  TextColumn get lat => text()();
  TextColumn get lng => text()();
}
