import 'package:data/src/tables/user/user_table.dart';
import 'package:drift/drift.dart';

@DataClassName("Company")
class Companies extends Table {
  IntColumn get userId => integer().references(Users, #id)();
  TextColumn get name => text()();
  TextColumn get catchPhrase => text()();
  TextColumn get bs => text()();
}
