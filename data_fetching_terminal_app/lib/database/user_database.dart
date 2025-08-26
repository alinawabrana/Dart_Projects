import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';

part 'user_database.g.dart';

class UserTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get firstName => text()();
  TextColumn get lastName => text()();
  IntColumn get yearOfBirth =>
      integer().check(yearOfBirth.isBetween(Constant(1000), Constant(9999)))();
  TextColumn get country => text()();
}

@DriftDatabase(tables: [UserTable])
class UserDatabase extends _$UserDatabase {
  UserDatabase([QueryExecutor? executor])
    : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return NativeDatabase.createInBackground(
      File(
        'lib${Platform.pathSeparator}database${Platform.pathSeparator}sqlite.db',
      ),
      setup: (rawDb) {
        rawDb.execute('PRAGMA foreign_keys = ON');
      },
    );
  }
}
