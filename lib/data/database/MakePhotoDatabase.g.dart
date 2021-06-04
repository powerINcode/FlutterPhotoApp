// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MakePhotoDatabase.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorMakePhotoDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$MakePhotoDatabaseBuilder databaseBuilder(String name) =>
      _$MakePhotoDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$MakePhotoDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$MakePhotoDatabaseBuilder(null);
}

class _$MakePhotoDatabaseBuilder {
  _$MakePhotoDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$MakePhotoDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$MakePhotoDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<MakePhotoDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$MakePhotoDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$MakePhotoDatabase extends MakePhotoDatabase {
  _$MakePhotoDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  PhotoDao? _photoDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Photo` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `path` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PhotoDao get photoDao {
    return _photoDaoInstance ??= _$PhotoDao(database, changeListener);
  }
}

class _$PhotoDao extends PhotoDao {
  _$PhotoDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _photoDboInsertionAdapter = InsertionAdapter(
            database,
            'Photo',
            (PhotoDbo item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'path': item.path
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PhotoDbo> _photoDboInsertionAdapter;

  @override
  Future<PhotoDbo?> getPhoto(String path) async {
    return _queryAdapter.query('SELECT * FROM Photo WHERE path = ?1',
        mapper: (Map<String, Object?> row) => PhotoDbo(
            row['id'] as int?, row['name'] as String, row['path'] as String),
        arguments: [path]);
  }

  @override
  Future<List<PhotoDbo>?> getPhotos() async {
    return _queryAdapter.queryList('SELECT * FROM Photo',
        mapper: (Map<String, Object?> row) => PhotoDbo(
            row['id'] as int?, row['name'] as String, row['path'] as String));
  }

  @override
  Future<void> savePhoto(PhotoDbo photo) async {
    await _photoDboInsertionAdapter.insert(photo, OnConflictStrategy.abort);
  }
}
