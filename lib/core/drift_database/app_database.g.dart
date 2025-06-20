// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PostureDeviationsTable extends PostureDeviations
    with TableInfo<$PostureDeviationsTable, PostureDeviation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PostureDeviationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
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
  static const VerificationMeta _neckAngleMeta = const VerificationMeta(
    'neckAngle',
  );
  @override
  late final GeneratedColumn<double> neckAngle = GeneratedColumn<double>(
    'neck_angle',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shoulderAngleMeta = const VerificationMeta(
    'shoulderAngle',
  );
  @override
  late final GeneratedColumn<double> shoulderAngle = GeneratedColumn<double>(
    'shoulder_angle',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, neckAngle, shoulderAngle];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'posture_deviations';
  @override
  VerificationContext validateIntegrity(
    Insertable<PostureDeviation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('neck_angle')) {
      context.handle(
        _neckAngleMeta,
        neckAngle.isAcceptableOrUnknown(data['neck_angle']!, _neckAngleMeta),
      );
    } else if (isInserting) {
      context.missing(_neckAngleMeta);
    }
    if (data.containsKey('shoulder_angle')) {
      context.handle(
        _shoulderAngleMeta,
        shoulderAngle.isAcceptableOrUnknown(
          data['shoulder_angle']!,
          _shoulderAngleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_shoulderAngleMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PostureDeviation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PostureDeviation(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      neckAngle: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}neck_angle'],
      )!,
      shoulderAngle: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}shoulder_angle'],
      )!,
    );
  }

  @override
  $PostureDeviationsTable createAlias(String alias) {
    return $PostureDeviationsTable(attachedDatabase, alias);
  }
}

class PostureDeviation extends DataClass
    implements Insertable<PostureDeviation> {
  final int id;
  final double neckAngle;
  final double shoulderAngle;
  const PostureDeviation({
    required this.id,
    required this.neckAngle,
    required this.shoulderAngle,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['neck_angle'] = Variable<double>(neckAngle);
    map['shoulder_angle'] = Variable<double>(shoulderAngle);
    return map;
  }

  PostureDeviationsCompanion toCompanion(bool nullToAbsent) {
    return PostureDeviationsCompanion(
      id: Value(id),
      neckAngle: Value(neckAngle),
      shoulderAngle: Value(shoulderAngle),
    );
  }

  factory PostureDeviation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PostureDeviation(
      id: serializer.fromJson<int>(json['id']),
      neckAngle: serializer.fromJson<double>(json['neckAngle']),
      shoulderAngle: serializer.fromJson<double>(json['shoulderAngle']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'neckAngle': serializer.toJson<double>(neckAngle),
      'shoulderAngle': serializer.toJson<double>(shoulderAngle),
    };
  }

  PostureDeviation copyWith({
    int? id,
    double? neckAngle,
    double? shoulderAngle,
  }) => PostureDeviation(
    id: id ?? this.id,
    neckAngle: neckAngle ?? this.neckAngle,
    shoulderAngle: shoulderAngle ?? this.shoulderAngle,
  );
  PostureDeviation copyWithCompanion(PostureDeviationsCompanion data) {
    return PostureDeviation(
      id: data.id.present ? data.id.value : this.id,
      neckAngle: data.neckAngle.present ? data.neckAngle.value : this.neckAngle,
      shoulderAngle: data.shoulderAngle.present
          ? data.shoulderAngle.value
          : this.shoulderAngle,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PostureDeviation(')
          ..write('id: $id, ')
          ..write('neckAngle: $neckAngle, ')
          ..write('shoulderAngle: $shoulderAngle')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, neckAngle, shoulderAngle);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PostureDeviation &&
          other.id == this.id &&
          other.neckAngle == this.neckAngle &&
          other.shoulderAngle == this.shoulderAngle);
}

class PostureDeviationsCompanion extends UpdateCompanion<PostureDeviation> {
  final Value<int> id;
  final Value<double> neckAngle;
  final Value<double> shoulderAngle;
  const PostureDeviationsCompanion({
    this.id = const Value.absent(),
    this.neckAngle = const Value.absent(),
    this.shoulderAngle = const Value.absent(),
  });
  PostureDeviationsCompanion.insert({
    this.id = const Value.absent(),
    required double neckAngle,
    required double shoulderAngle,
  }) : neckAngle = Value(neckAngle),
       shoulderAngle = Value(shoulderAngle);
  static Insertable<PostureDeviation> custom({
    Expression<int>? id,
    Expression<double>? neckAngle,
    Expression<double>? shoulderAngle,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (neckAngle != null) 'neck_angle': neckAngle,
      if (shoulderAngle != null) 'shoulder_angle': shoulderAngle,
    });
  }

  PostureDeviationsCompanion copyWith({
    Value<int>? id,
    Value<double>? neckAngle,
    Value<double>? shoulderAngle,
  }) {
    return PostureDeviationsCompanion(
      id: id ?? this.id,
      neckAngle: neckAngle ?? this.neckAngle,
      shoulderAngle: shoulderAngle ?? this.shoulderAngle,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (neckAngle.present) {
      map['neck_angle'] = Variable<double>(neckAngle.value);
    }
    if (shoulderAngle.present) {
      map['shoulder_angle'] = Variable<double>(shoulderAngle.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PostureDeviationsCompanion(')
          ..write('id: $id, ')
          ..write('neckAngle: $neckAngle, ')
          ..write('shoulderAngle: $shoulderAngle')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PostureDeviationsTable postureDeviations =
      $PostureDeviationsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [postureDeviations];
}

typedef $$PostureDeviationsTableCreateCompanionBuilder =
    PostureDeviationsCompanion Function({
      Value<int> id,
      required double neckAngle,
      required double shoulderAngle,
    });
typedef $$PostureDeviationsTableUpdateCompanionBuilder =
    PostureDeviationsCompanion Function({
      Value<int> id,
      Value<double> neckAngle,
      Value<double> shoulderAngle,
    });

class $$PostureDeviationsTableFilterComposer
    extends Composer<_$AppDatabase, $PostureDeviationsTable> {
  $$PostureDeviationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get neckAngle => $composableBuilder(
    column: $table.neckAngle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get shoulderAngle => $composableBuilder(
    column: $table.shoulderAngle,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PostureDeviationsTableOrderingComposer
    extends Composer<_$AppDatabase, $PostureDeviationsTable> {
  $$PostureDeviationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get neckAngle => $composableBuilder(
    column: $table.neckAngle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get shoulderAngle => $composableBuilder(
    column: $table.shoulderAngle,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PostureDeviationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PostureDeviationsTable> {
  $$PostureDeviationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get neckAngle =>
      $composableBuilder(column: $table.neckAngle, builder: (column) => column);

  GeneratedColumn<double> get shoulderAngle => $composableBuilder(
    column: $table.shoulderAngle,
    builder: (column) => column,
  );
}

class $$PostureDeviationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PostureDeviationsTable,
          PostureDeviation,
          $$PostureDeviationsTableFilterComposer,
          $$PostureDeviationsTableOrderingComposer,
          $$PostureDeviationsTableAnnotationComposer,
          $$PostureDeviationsTableCreateCompanionBuilder,
          $$PostureDeviationsTableUpdateCompanionBuilder,
          (
            PostureDeviation,
            BaseReferences<
              _$AppDatabase,
              $PostureDeviationsTable,
              PostureDeviation
            >,
          ),
          PostureDeviation,
          PrefetchHooks Function()
        > {
  $$PostureDeviationsTableTableManager(
    _$AppDatabase db,
    $PostureDeviationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PostureDeviationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PostureDeviationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PostureDeviationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<double> neckAngle = const Value.absent(),
                Value<double> shoulderAngle = const Value.absent(),
              }) => PostureDeviationsCompanion(
                id: id,
                neckAngle: neckAngle,
                shoulderAngle: shoulderAngle,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required double neckAngle,
                required double shoulderAngle,
              }) => PostureDeviationsCompanion.insert(
                id: id,
                neckAngle: neckAngle,
                shoulderAngle: shoulderAngle,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PostureDeviationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PostureDeviationsTable,
      PostureDeviation,
      $$PostureDeviationsTableFilterComposer,
      $$PostureDeviationsTableOrderingComposer,
      $$PostureDeviationsTableAnnotationComposer,
      $$PostureDeviationsTableCreateCompanionBuilder,
      $$PostureDeviationsTableUpdateCompanionBuilder,
      (
        PostureDeviation,
        BaseReferences<
          _$AppDatabase,
          $PostureDeviationsTable,
          PostureDeviation
        >,
      ),
      PostureDeviation,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PostureDeviationsTableTableManager get postureDeviations =>
      $$PostureDeviationsTableTableManager(_db, _db.postureDeviations);
}
