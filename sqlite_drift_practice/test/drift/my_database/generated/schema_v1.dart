// dart format width=80
// GENERATED CODE, DO NOT EDIT BY HAND.
// ignore_for_file: type=lint
import 'package:drift/drift.dart';

class TodoItems extends Table with TableInfo<TodoItems, TodoItemsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  TodoItems(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression(
      'CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER)',
    ),
  );
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 6,
      maxTextLength: 32,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, createdAt, title, content];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'todo_items';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TodoItemsData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TodoItemsData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
    );
  }

  @override
  TodoItems createAlias(String alias) {
    return TodoItems(attachedDatabase, alias);
  }
}

class TodoItemsData extends DataClass implements Insertable<TodoItemsData> {
  final int id;
  final DateTime createdAt;
  final String title;
  final String content;
  const TodoItemsData({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.content,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['title'] = Variable<String>(title);
    map['body'] = Variable<String>(content);
    return map;
  }

  TodoItemsCompanion toCompanion(bool nullToAbsent) {
    return TodoItemsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      title: Value(title),
      content: Value(content),
    );
  }

  factory TodoItemsData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TodoItemsData(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
    };
  }

  TodoItemsData copyWith({
    int? id,
    DateTime? createdAt,
    String? title,
    String? content,
  }) => TodoItemsData(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    title: title ?? this.title,
    content: content ?? this.content,
  );
  TodoItemsData copyWithCompanion(TodoItemsCompanion data) {
    return TodoItemsData(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      title: data.title.present ? data.title.value : this.title,
      content: data.content.present ? data.content.value : this.content,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TodoItemsData(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('title: $title, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt, title, content);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TodoItemsData &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.title == this.title &&
          other.content == this.content);
}

class TodoItemsCompanion extends UpdateCompanion<TodoItemsData> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<String> title;
  final Value<String> content;
  const TodoItemsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
  });
  TodoItemsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    required String title,
    required String content,
  }) : title = Value(title),
       content = Value(content);
  static Insertable<TodoItemsData> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<String>? title,
    Expression<String>? content,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (title != null) 'title': title,
      if (content != null) 'body': content,
    });
  }

  TodoItemsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? createdAt,
    Value<String>? title,
    Value<String>? content,
  }) {
    return TodoItemsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      title: title ?? this.title,
      content: content ?? this.content,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (content.present) {
      map['body'] = Variable<String>(content.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodoItemsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('title: $title, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }
}

class Artist extends Table with TableInfo<Artist, ArtistData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Artist(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression(
      'CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER)',
    ),
  );
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, createdAt, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'artist';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ArtistData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ArtistData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  Artist createAlias(String alias) {
    return Artist(attachedDatabase, alias);
  }
}

class ArtistData extends DataClass implements Insertable<ArtistData> {
  final int id;
  final DateTime createdAt;
  final String name;
  const ArtistData({
    required this.id,
    required this.createdAt,
    required this.name,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['name'] = Variable<String>(name);
    return map;
  }

  ArtistCompanion toCompanion(bool nullToAbsent) {
    return ArtistCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      name: Value(name),
    );
  }

  factory ArtistData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ArtistData(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'name': serializer.toJson<String>(name),
    };
  }

  ArtistData copyWith({int? id, DateTime? createdAt, String? name}) =>
      ArtistData(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        name: name ?? this.name,
      );
  ArtistData copyWithCompanion(ArtistCompanion data) {
    return ArtistData(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ArtistData(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ArtistData &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.name == this.name);
}

class ArtistCompanion extends UpdateCompanion<ArtistData> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<String> name;
  const ArtistCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.name = const Value.absent(),
  });
  ArtistCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<ArtistData> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (name != null) 'name': name,
    });
  }

  ArtistCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? createdAt,
    Value<String>? name,
  }) {
    return ArtistCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArtistCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class Albums extends Table with TableInfo<Albums, AlbumsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Albums(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression(
      'CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER)',
    ),
  );
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<int> artist = GeneratedColumn<int>(
    'artist',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES artist (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, createdAt, name, artist];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'albums';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AlbumsData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AlbumsData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      artist: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}artist'],
      )!,
    );
  }

  @override
  Albums createAlias(String alias) {
    return Albums(attachedDatabase, alias);
  }
}

class AlbumsData extends DataClass implements Insertable<AlbumsData> {
  final int id;
  final DateTime createdAt;
  final String name;
  final int artist;
  const AlbumsData({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.artist,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['name'] = Variable<String>(name);
    map['artist'] = Variable<int>(artist);
    return map;
  }

  AlbumsCompanion toCompanion(bool nullToAbsent) {
    return AlbumsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      name: Value(name),
      artist: Value(artist),
    );
  }

  factory AlbumsData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AlbumsData(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      name: serializer.fromJson<String>(json['name']),
      artist: serializer.fromJson<int>(json['artist']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'name': serializer.toJson<String>(name),
      'artist': serializer.toJson<int>(artist),
    };
  }

  AlbumsData copyWith({
    int? id,
    DateTime? createdAt,
    String? name,
    int? artist,
  }) => AlbumsData(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    name: name ?? this.name,
    artist: artist ?? this.artist,
  );
  AlbumsData copyWithCompanion(AlbumsCompanion data) {
    return AlbumsData(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      name: data.name.present ? data.name.value : this.name,
      artist: data.artist.present ? data.artist.value : this.artist,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AlbumsData(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('name: $name, ')
          ..write('artist: $artist')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt, name, artist);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AlbumsData &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.name == this.name &&
          other.artist == this.artist);
}

class AlbumsCompanion extends UpdateCompanion<AlbumsData> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<String> name;
  final Value<int> artist;
  const AlbumsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.name = const Value.absent(),
    this.artist = const Value.absent(),
  });
  AlbumsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    required String name,
    required int artist,
  }) : name = Value(name),
       artist = Value(artist);
  static Insertable<AlbumsData> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<String>? name,
    Expression<int>? artist,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (name != null) 'name': name,
      if (artist != null) 'artist': artist,
    });
  }

  AlbumsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? createdAt,
    Value<String>? name,
    Value<int>? artist,
  }) {
    return AlbumsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      artist: artist ?? this.artist,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (artist.present) {
      map['artist'] = Variable<int>(artist.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlbumsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('name: $name, ')
          ..write('artist: $artist')
          ..write(')'))
        .toString();
  }
}

class DatabaseAtV1 extends GeneratedDatabase {
  DatabaseAtV1(QueryExecutor e) : super(e);
  late final TodoItems todoItems = TodoItems(this);
  late final Artist artist = Artist(this);
  late final Albums albums = Albums(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    todoItems,
    artist,
    albums,
  ];
  @override
  int get schemaVersion => 1;
}
