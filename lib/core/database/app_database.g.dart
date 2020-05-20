// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Site extends DataClass implements Insertable<Site> {
  final int id;
  final String name;
  final String address;
  final int quantity;
  final String image;
  final DateTime update;
  Site(
      {this.id,
      this.name,
      this.address,
      this.quantity,
      this.image,
      this.update});
  factory Site.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Site(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      address:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}address']),
      quantity:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}quantity']),
      image:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}image']),
      update: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}update']),
    );
  }
  factory Site.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Site(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      address: serializer.fromJson<String>(json['address']),
      quantity: serializer.fromJson<int>(json['quantity']),
      image: serializer.fromJson<String>(json['image']),
      update: serializer.fromJson<DateTime>(json['update']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'address': serializer.toJson<String>(address),
      'quantity': serializer.toJson<int>(quantity),
      'image': serializer.toJson<String>(image),
      'update': serializer.toJson<DateTime>(update),
    };
  }

  @override
  SitesCompanion createCompanion(bool nullToAbsent) {
    return SitesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      quantity: quantity == null && nullToAbsent
          ? const Value.absent()
          : Value(quantity),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
      update:
          update == null && nullToAbsent ? const Value.absent() : Value(update),
    );
  }

  Site copyWith(
          {int id,
          String name,
          String address,
          int quantity,
          String image,
          DateTime update}) =>
      Site(
        id: id ?? this.id,
        name: name ?? this.name,
        address: address ?? this.address,
        quantity: quantity ?? this.quantity,
        image: image ?? this.image,
        update: update ?? this.update,
      );
  @override
  String toString() {
    return (StringBuffer('Site(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('quantity: $quantity, ')
          ..write('image: $image, ')
          ..write('update: $update')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              address.hashCode,
              $mrjc(quantity.hashCode,
                  $mrjc(image.hashCode, update.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Site &&
          other.id == this.id &&
          other.name == this.name &&
          other.address == this.address &&
          other.quantity == this.quantity &&
          other.image == this.image &&
          other.update == this.update);
}

class SitesCompanion extends UpdateCompanion<Site> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> address;
  final Value<int> quantity;
  final Value<String> image;
  final Value<DateTime> update;
  const SitesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.address = const Value.absent(),
    this.quantity = const Value.absent(),
    this.image = const Value.absent(),
    this.update = const Value.absent(),
  });
  SitesCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.address = const Value.absent(),
    this.quantity = const Value.absent(),
    this.image = const Value.absent(),
    this.update = const Value.absent(),
  });
  SitesCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<String> address,
      Value<int> quantity,
      Value<String> image,
      Value<DateTime> update}) {
    return SitesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      quantity: quantity ?? this.quantity,
      image: image ?? this.image,
      update: update ?? this.update,
    );
  }
}

class $SitesTable extends Sites with TableInfo<$SitesTable, Site> {
  final GeneratedDatabase _db;
  final String _alias;
  $SitesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, true,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _addressMeta = const VerificationMeta('address');
  GeneratedTextColumn _address;
  @override
  GeneratedTextColumn get address => _address ??= _constructAddress();
  GeneratedTextColumn _constructAddress() {
    return GeneratedTextColumn(
      'address',
      $tableName,
      true,
    );
  }

  final VerificationMeta _quantityMeta = const VerificationMeta('quantity');
  GeneratedIntColumn _quantity;
  @override
  GeneratedIntColumn get quantity => _quantity ??= _constructQuantity();
  GeneratedIntColumn _constructQuantity() {
    return GeneratedIntColumn(
      'quantity',
      $tableName,
      true,
    );
  }

  final VerificationMeta _imageMeta = const VerificationMeta('image');
  GeneratedTextColumn _image;
  @override
  GeneratedTextColumn get image => _image ??= _constructImage();
  GeneratedTextColumn _constructImage() {
    return GeneratedTextColumn(
      'image',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updateMeta = const VerificationMeta('update');
  GeneratedDateTimeColumn _update;
  @override
  GeneratedDateTimeColumn get update => _update ??= _constructUpdate();
  GeneratedDateTimeColumn _constructUpdate() {
    return GeneratedDateTimeColumn(
      'update',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, name, address, quantity, image, update];
  @override
  $SitesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'sites';
  @override
  final String actualTableName = 'sites';
  @override
  VerificationContext validateIntegrity(SitesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    }
    if (d.address.present) {
      context.handle(_addressMeta,
          address.isAcceptableValue(d.address.value, _addressMeta));
    }
    if (d.quantity.present) {
      context.handle(_quantityMeta,
          quantity.isAcceptableValue(d.quantity.value, _quantityMeta));
    }
    if (d.image.present) {
      context.handle(
          _imageMeta, image.isAcceptableValue(d.image.value, _imageMeta));
    }
    if (d.update.present) {
      context.handle(
          _updateMeta, update.isAcceptableValue(d.update.value, _updateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Site map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Site.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(SitesCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.address.present) {
      map['address'] = Variable<String, StringType>(d.address.value);
    }
    if (d.quantity.present) {
      map['quantity'] = Variable<int, IntType>(d.quantity.value);
    }
    if (d.image.present) {
      map['image'] = Variable<String, StringType>(d.image.value);
    }
    if (d.update.present) {
      map['update'] = Variable<DateTime, DateTimeType>(d.update.value);
    }
    return map;
  }

  @override
  $SitesTable createAlias(String alias) {
    return $SitesTable(_db, alias);
  }
}

class Barn extends DataClass implements Insertable<Barn> {
  final int id;
  final String name;
  final int quantity;
  final int site_id;
  final DateTime update;
  Barn({this.id, this.name, this.quantity, this.site_id, this.update});
  factory Barn.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Barn(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      quantity:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}quantity']),
      site_id:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}site_id']),
      update: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}update']),
    );
  }
  factory Barn.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Barn(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      quantity: serializer.fromJson<int>(json['quantity']),
      site_id: serializer.fromJson<int>(json['site_id']),
      update: serializer.fromJson<DateTime>(json['update']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'quantity': serializer.toJson<int>(quantity),
      'site_id': serializer.toJson<int>(site_id),
      'update': serializer.toJson<DateTime>(update),
    };
  }

  @override
  BarnsCompanion createCompanion(bool nullToAbsent) {
    return BarnsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      quantity: quantity == null && nullToAbsent
          ? const Value.absent()
          : Value(quantity),
      site_id: site_id == null && nullToAbsent
          ? const Value.absent()
          : Value(site_id),
      update:
          update == null && nullToAbsent ? const Value.absent() : Value(update),
    );
  }

  Barn copyWith(
          {int id, String name, int quantity, int site_id, DateTime update}) =>
      Barn(
        id: id ?? this.id,
        name: name ?? this.name,
        quantity: quantity ?? this.quantity,
        site_id: site_id ?? this.site_id,
        update: update ?? this.update,
      );
  @override
  String toString() {
    return (StringBuffer('Barn(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('quantity: $quantity, ')
          ..write('site_id: $site_id, ')
          ..write('update: $update')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(name.hashCode,
          $mrjc(quantity.hashCode, $mrjc(site_id.hashCode, update.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Barn &&
          other.id == this.id &&
          other.name == this.name &&
          other.quantity == this.quantity &&
          other.site_id == this.site_id &&
          other.update == this.update);
}

class BarnsCompanion extends UpdateCompanion<Barn> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> quantity;
  final Value<int> site_id;
  final Value<DateTime> update;
  const BarnsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.quantity = const Value.absent(),
    this.site_id = const Value.absent(),
    this.update = const Value.absent(),
  });
  BarnsCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.quantity = const Value.absent(),
    this.site_id = const Value.absent(),
    this.update = const Value.absent(),
  });
  BarnsCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<int> quantity,
      Value<int> site_id,
      Value<DateTime> update}) {
    return BarnsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      site_id: site_id ?? this.site_id,
      update: update ?? this.update,
    );
  }
}

class $BarnsTable extends Barns with TableInfo<$BarnsTable, Barn> {
  final GeneratedDatabase _db;
  final String _alias;
  $BarnsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, true,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _quantityMeta = const VerificationMeta('quantity');
  GeneratedIntColumn _quantity;
  @override
  GeneratedIntColumn get quantity => _quantity ??= _constructQuantity();
  GeneratedIntColumn _constructQuantity() {
    return GeneratedIntColumn(
      'quantity',
      $tableName,
      true,
    );
  }

  final VerificationMeta _site_idMeta = const VerificationMeta('site_id');
  GeneratedIntColumn _site_id;
  @override
  GeneratedIntColumn get site_id => _site_id ??= _constructSiteId();
  GeneratedIntColumn _constructSiteId() {
    return GeneratedIntColumn('site_id', $tableName, true,
        $customConstraints: 'NULL REFERENCES sites(id)');
  }

  final VerificationMeta _updateMeta = const VerificationMeta('update');
  GeneratedDateTimeColumn _update;
  @override
  GeneratedDateTimeColumn get update => _update ??= _constructUpdate();
  GeneratedDateTimeColumn _constructUpdate() {
    return GeneratedDateTimeColumn(
      'update',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, quantity, site_id, update];
  @override
  $BarnsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'barns';
  @override
  final String actualTableName = 'barns';
  @override
  VerificationContext validateIntegrity(BarnsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    }
    if (d.quantity.present) {
      context.handle(_quantityMeta,
          quantity.isAcceptableValue(d.quantity.value, _quantityMeta));
    }
    if (d.site_id.present) {
      context.handle(_site_idMeta,
          site_id.isAcceptableValue(d.site_id.value, _site_idMeta));
    }
    if (d.update.present) {
      context.handle(
          _updateMeta, update.isAcceptableValue(d.update.value, _updateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Barn map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Barn.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(BarnsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.quantity.present) {
      map['quantity'] = Variable<int, IntType>(d.quantity.value);
    }
    if (d.site_id.present) {
      map['site_id'] = Variable<int, IntType>(d.site_id.value);
    }
    if (d.update.present) {
      map['update'] = Variable<DateTime, DateTimeType>(d.update.value);
    }
    return map;
  }

  @override
  $BarnsTable createAlias(String alias) {
    return $BarnsTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $SitesTable _sites;
  $SitesTable get sites => _sites ??= $SitesTable(this);
  $BarnsTable _barns;
  $BarnsTable get barns => _barns ??= $BarnsTable(this);
  SiteDao _siteDao;
  SiteDao get siteDao => _siteDao ??= SiteDao(this as AppDatabase);
  BarnDao _barnDao;
  BarnDao get barnDao => _barnDao ??= BarnDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [sites, barns];
}
