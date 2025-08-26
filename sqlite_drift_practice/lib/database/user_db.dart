import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';

part 'user_db.g.dart';

mixin TableMixin on Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class TodoItems extends Table with TableMixin {
  TextColumn get title => text().withLength(min: 6, max: 32)();
  TextColumn get content => text().named('body')();
}

class Albums extends Table with TableMixin {
  TextColumn get name => text()();
  IntColumn get artist => integer().references(Artist, #id)();
}

class Artist extends Table with TableMixin {
  TextColumn get name => text()();
}

@DriftDatabase(tables: [TodoItems, Albums, Artist])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return NativeDatabase.createInBackground(
      File('sqlite.db'),
      setup: (rawDb) {
        // ✅ Enable foreign key enforcement
        rawDb.execute('PRAGMA foreign_keys = ON');
      },
    );
  }
}
