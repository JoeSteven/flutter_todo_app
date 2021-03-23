// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDataBase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDataBaseBuilder databaseBuilder(String name) =>
      _$AppDataBaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDataBaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDataBaseBuilder(null);
}

class _$AppDataBaseBuilder {
  _$AppDataBaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDataBaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDataBaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDataBase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDataBase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDataBase extends AppDataBase {
  _$AppDataBase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TodoTaskDao? _todoTaskDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
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
            'CREATE TABLE IF NOT EXISTS `TodoTask` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `title` TEXT NOT NULL, `isFinished` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TodoTaskDao get todoTaskDao {
    return _todoTaskDaoInstance ??= _$TodoTaskDao(database, changeListener);
  }
}

class _$TodoTaskDao extends TodoTaskDao {
  _$TodoTaskDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _todoTaskInsertionAdapter = InsertionAdapter(
            database,
            'TodoTask',
            (TodoTask item) => <String, Object?>{
                  'title': item.title,
                  'isFinished': item.isFinished ? 1 : 0
                }),
        _todoTaskUpdateAdapter = UpdateAdapter(
            database,
            'TodoTask',
            ['id'],
            (TodoTask item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'isFinished': item.isFinished ? 1 : 0
                }),
        _todoTaskDeletionAdapter = DeletionAdapter(
            database,
            'TodoTask',
            ['id'],
            (TodoTask item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'isFinished': item.isFinished ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TodoTask> _todoTaskInsertionAdapter;

  final UpdateAdapter<TodoTask> _todoTaskUpdateAdapter;

  final DeletionAdapter<TodoTask> _todoTaskDeletionAdapter;

  @override
  Future<List<TodoTask>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM TodoTask',
        mapper: (Map<String, Object?> row) => TodoTask(
            row['id'] as int, row['title'] as String,
            isFinished: (row['isFinished'] as int) != 0));
  }

  @override
  Future<int> insertTask(TodoTask task) {
    return _todoTaskInsertionAdapter.insertAndReturnId(
        task, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateTask(TodoTask task) {
    return _todoTaskUpdateAdapter.updateAndReturnChangedRows(
        task, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteTask(TodoTask task) {
    return _todoTaskDeletionAdapter.deleteAndReturnChangedRows(task);
  }
}
