import 'package:drift/drift.dart';

@DataClassName('User')
class Users extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get username => text()();
  TextColumn get email => text()();
  TextColumn get phone => text()();
  TextColumn get website => text()();

  @override
  Set<Column<Object>>? get primaryKey => <Column<Object>>{id};
}
