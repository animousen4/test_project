import 'package:drift/drift.dart';

import 'user_table.dart';

@DataClassName('Company')
class Companies extends Table {
  IntColumn get userId => integer().unique().references(Users, #id)();
  TextColumn get name => text()();
  TextColumn get catchPhrase => text()();
  TextColumn get bs => text()();
}
