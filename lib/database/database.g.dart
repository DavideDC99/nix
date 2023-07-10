// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  StepDao? _stepDaoInstance;

  SleepDao? _sleepDaoInstance;

  StatsDao? _statsDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
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
            'CREATE TABLE IF NOT EXISTS `Steps` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `dateTime` INTEGER NOT NULL, `value` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Sleep` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `dateTime` INTEGER NOT NULL, `start` INTEGER NOT NULL, `end` INTEGER NOT NULL, `duration` REAL NOT NULL, `eff` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Stats` (`id` INTEGER NOT NULL, `month` INTEGER NOT NULL, `score` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  StepDao get stepDao {
    return _stepDaoInstance ??= _$StepDao(database, changeListener);
  }

  @override
  SleepDao get sleepDao {
    return _sleepDaoInstance ??= _$SleepDao(database, changeListener);
  }

  @override
  StatsDao get statsDao {
    return _statsDaoInstance ??= _$StatsDao(database, changeListener);
  }
}

class _$StepDao extends StepDao {
  _$StepDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _stepsInsertionAdapter = InsertionAdapter(
            database,
            'Steps',
            (Steps item) => <String, Object?>{
                  'id': item.id,
                  'dateTime': _dateTimeConverter.encode(item.dateTime),
                  'value': item.value
                }),
        _stepsUpdateAdapter = UpdateAdapter(
            database,
            'Steps',
            ['id'],
            (Steps item) => <String, Object?>{
                  'id': item.id,
                  'dateTime': _dateTimeConverter.encode(item.dateTime),
                  'value': item.value
                }),
        _stepsDeletionAdapter = DeletionAdapter(
            database,
            'Steps',
            ['id'],
            (Steps item) => <String, Object?>{
                  'id': item.id,
                  'dateTime': _dateTimeConverter.encode(item.dateTime),
                  'value': item.value
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Steps> _stepsInsertionAdapter;

  final UpdateAdapter<Steps> _stepsUpdateAdapter;

  final DeletionAdapter<Steps> _stepsDeletionAdapter;

  @override
  Future<int?> findStepsbyDate(
    DateTime startTime,
    DateTime endTime,
  ) async {
    return _queryAdapter.query(
        'SELECT SUM(value) FROM Steps WHERE dateTime between ?1 and ?2',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [
          _dateTimeConverter.encode(startTime),
          _dateTimeConverter.encode(endTime)
        ]);
  }

  @override
  Future<List<Steps>> findAllSteps() async {
    return _queryAdapter.queryList('SELECT * FROM Steps',
        mapper: (Map<String, Object?> row) => Steps(
            row['id'] as int?,
            _dateTimeConverter.decode(row['dateTime'] as int),
            row['value'] as int?));
  }

  @override
  Future<Steps?> findFirstDayInDb() async {
    return _queryAdapter.query(
        'SELECT * FROM Steps ORDER BY dateTime ASC LIMIT 1',
        mapper: (Map<String, Object?> row) => Steps(
            row['id'] as int?,
            _dateTimeConverter.decode(row['dateTime'] as int),
            row['value'] as int?));
  }

  @override
  Future<Steps?> findLastDayInDb() async {
    return _queryAdapter.query(
        'SELECT * FROM Steps ORDER BY dateTime DESC LIMIT 1',
        mapper: (Map<String, Object?> row) => Steps(
            row['id'] as int?,
            _dateTimeConverter.decode(row['dateTime'] as int),
            row['value'] as int?));
  }

  @override
  Future<void> insertStep(Steps steps) async {
    await _stepsInsertionAdapter.insert(steps, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateStep(Steps steps) async {
    await _stepsUpdateAdapter.update(steps, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteStep(Steps steps) async {
    await _stepsDeletionAdapter.delete(steps);
  }
}

class _$SleepDao extends SleepDao {
  _$SleepDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _sleepInsertionAdapter = InsertionAdapter(
            database,
            'Sleep',
            (Sleep item) => <String, Object?>{
                  'id': item.id,
                  'dateTime': _dateTimeConverter.encode(item.dateTime),
                  'start': _dateTimeConverter.encode(item.start),
                  'end': _dateTimeConverter.encode(item.end),
                  'duration': item.duration,
                  'eff': item.eff
                }),
        _sleepUpdateAdapter = UpdateAdapter(
            database,
            'Sleep',
            ['id'],
            (Sleep item) => <String, Object?>{
                  'id': item.id,
                  'dateTime': _dateTimeConverter.encode(item.dateTime),
                  'start': _dateTimeConverter.encode(item.start),
                  'end': _dateTimeConverter.encode(item.end),
                  'duration': item.duration,
                  'eff': item.eff
                }),
        _sleepDeletionAdapter = DeletionAdapter(
            database,
            'Sleep',
            ['id'],
            (Sleep item) => <String, Object?>{
                  'id': item.id,
                  'dateTime': _dateTimeConverter.encode(item.dateTime),
                  'start': _dateTimeConverter.encode(item.start),
                  'end': _dateTimeConverter.encode(item.end),
                  'duration': item.duration,
                  'eff': item.eff
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Sleep> _sleepInsertionAdapter;

  final UpdateAdapter<Sleep> _sleepUpdateAdapter;

  final DeletionAdapter<Sleep> _sleepDeletionAdapter;

  @override
  Future<int?> findBedTime(DateTime time) async {
    return _queryAdapter.query('SELECT start FROM Sleep WHERE dateTime = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [_dateTimeConverter.encode(time)]);
  }

  @override
  Future<int?> findWakeup(DateTime time) async {
    return _queryAdapter.query('SELECT end FROM Sleep WHERE dateTime = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [_dateTimeConverter.encode(time)]);
  }

  @override
  Future<double?> findSleepDuration(DateTime time) async {
    return _queryAdapter.query('SELECT duration FROM Sleep WHERE dateTime = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as double,
        arguments: [_dateTimeConverter.encode(time)]);
  }

  @override
  Future<int?> findSleepEff(DateTime time) async {
    return _queryAdapter.query('SELECT eff FROM Sleep WHERE dateTime = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [_dateTimeConverter.encode(time)]);
  }

  @override
  Future<Sleep?> findFirstDayInDb() async {
    return _queryAdapter.query(
        'SELECT * FROM Exposure ORDER BY dateTime ASC LIMIT 1',
        mapper: (Map<String, Object?> row) => Sleep(
            row['id'] as int?,
            _dateTimeConverter.decode(row['dateTime'] as int),
            _dateTimeConverter.decode(row['start'] as int),
            _dateTimeConverter.decode(row['end'] as int),
            row['duration'] as double,
            row['eff'] as int));
  }

  @override
  Future<Sleep?> findLastDayInDb() async {
    return _queryAdapter.query(
        'SELECT * FROM Exposure ORDER BY dateTime DESC LIMIT 1',
        mapper: (Map<String, Object?> row) => Sleep(
            row['id'] as int?,
            _dateTimeConverter.decode(row['dateTime'] as int),
            _dateTimeConverter.decode(row['start'] as int),
            _dateTimeConverter.decode(row['end'] as int),
            row['duration'] as double,
            row['eff'] as int));
  }

  @override
  Future<void> insertSleep(Sleep sleep) async {
    await _sleepInsertionAdapter.insert(sleep, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateSleep(Sleep sleep) async {
    await _sleepUpdateAdapter.update(sleep, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteSleep(Sleep sleep) async {
    await _sleepDeletionAdapter.delete(sleep);
  }
}

class _$StatsDao extends StatsDao {
  _$StatsDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _statsInsertionAdapter = InsertionAdapter(
            database,
            'Stats',
            (Stats item) => <String, Object?>{
                  'id': item.id,
                  'month': item.month,
                  'score': item.score
                }),
        _statsUpdateAdapter = UpdateAdapter(
            database,
            'Stats',
            ['id'],
            (Stats item) => <String, Object?>{
                  'id': item.id,
                  'month': item.month,
                  'score': item.score
                }),
        _statsDeletionAdapter = DeletionAdapter(
            database,
            'Stats',
            ['id'],
            (Stats item) => <String, Object?>{
                  'id': item.id,
                  'month': item.month,
                  'score': item.score
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Stats> _statsInsertionAdapter;

  final UpdateAdapter<Stats> _statsUpdateAdapter;

  final DeletionAdapter<Stats> _statsDeletionAdapter;

  @override
  Future<int?> findScore(
    int month,
    int id,
  ) async {
    return _queryAdapter.query(
        'SELECT score FROM Stats WHERE month = ?1 AND id =?2',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [month, id]);
  }

  @override
  Future<void> insertScore(Stats stats) async {
    await _statsInsertionAdapter.insert(stats, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateScore(Stats stats) async {
    await _statsUpdateAdapter.update(stats, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteScore(Stats stats) async {
    await _statsDeletionAdapter.delete(stats);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
