import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:sqlite_drift_practice/database/tables/tables.dart';
import 'user_db.steps.dart';
part 'user_db.g.dart';

@DriftDatabase(tables: [TodoItems, Albums, Artist, Groups, Common])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 3;

  static QueryExecutor _openConnection() {
    return NativeDatabase.createInBackground(
      File('sqlite.db'),
      setup: (database) {
        database.execute('PRAGMA foreign_keys = ON');
      },
    );
  }

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async => await m.createAll(),
      onUpgrade: stepByStep(
        from1To2: (m, schema) async {
          await m.createTable(schema.groups);
        },
        from2To3: (m, schema) async {
          await m.createTable(schema.common);
        },
      ),
      beforeOpen: (details) async {
        if (details.wasCreated) {
          await into(todoItems).insert(
            TodoItem(
              id: 0,
              createdAt: DateTime.now(),
              title: 'First Data',
              content: 'First Data Content...',
            ),
          );

          // await into(todos).insert(
          //   TodoEntry(
          //     content: 'A first todo entry',
          //     category: null,
          //     targetDate: DateTime.now(),
          //   ),
          // );

          // await into(todos).insert(
          //   TodoEntry(
          //     content: 'Rework persistence code',
          //     category: workId,
          //     targetDate: DateTime.now().add(const Duration(days: 4)),
          //   ),
          // );
        }
      },
      // onUpgrade: (m, from, to) async {
      //   // Here m = Migration, from = from which step and to = to which step
      //   if(from < 2){
      //     await m.createTable(groups);
      //   }
      // },
    );
  }
}
