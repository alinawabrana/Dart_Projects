import 'package:drift/drift.dart';

mixin TableMixin on Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class TodoItems extends Table with TableMixin {
  TextColumn get title => text().withLength(min: 6, max: 32)();
  TextColumn get content => text().named('body')();
}

class Artist extends Table with TableMixin {
  TextColumn get name => text()();
}

// This table carries many to many relations
class Common extends Table {
  IntColumn get artistId => integer().references(Artist, #id)();
  IntColumn get albumId => integer().references(Albums, #id)();
  @override
  Set<Column<Object>>? get primaryKey => {artistId, albumId};
}

class Albums extends Table with TableMixin {
  TextColumn get name => text()();
  // Below gives many to one relation. Many albums can have the same artist
  IntColumn get artist => integer().references(Artist, #id)();
}

class Groups extends Table with TableMixin {
  TextColumn get name => text()();
}
